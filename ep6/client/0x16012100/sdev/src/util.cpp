#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <include/util.h>

int util::detour(Address addr, Function func, int size)
{
    constexpr int stmt_size = 5;
    constexpr unsigned char nop = 0x90;
    constexpr unsigned char jmp = 0xE9;

    if (size < stmt_size)
        return 0;

    unsigned long protect;
    if (!VirtualProtect(addr, size, PAGE_EXECUTE_READWRITE, &protect))
        return 0;

    auto dest = reinterpret_cast<unsigned>(func) - reinterpret_cast<unsigned>(addr);
    dest -= stmt_size;

    memset(addr, nop, size);
    memset(addr, jmp, 1);
    __asm { inc addr }
    memcpy(addr, &dest, 4);
    __asm { dec addr }

    return VirtualProtect(addr, size, protect, &protect);
}

int util::write_memory(Address addr, Buffer buffer, int size)
{
    if (size < 1)
        return 0;

    unsigned long protect;
    if (!VirtualProtect(addr, size, PAGE_EXECUTE_READWRITE, &protect))
        return 0;

    if (!WriteProcessMemory(GetCurrentProcess(), addr, buffer, size, nullptr))
        return 0;

    return VirtualProtect(addr, size, protect, &protect);
}
