#pragma once
#include <string>

namespace util
{
    using namespace System;

    typedef void* Address;
    typedef void* Buffer;
    typedef unsigned char* ByteArray;
    typedef void* Function;

    int detour(Address addr, Function func, int size);
    void log(const std::string& text);
    void log(String^ text);
    std::string marshal_string(String^ str);

    template<class T>
    auto read_bytes(ByteArray buffer, int offset)
    {
        T value{};
        memcpy(&value, &buffer[offset], sizeof(T));
        return value;
    }

    int write_memory(Address addr, Buffer buffer, int size);
}
