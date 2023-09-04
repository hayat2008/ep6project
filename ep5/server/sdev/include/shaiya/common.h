#pragma once

#if WIN32
#else
#error requires Win32 platform
#endif

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

// thanks Cups ^^
#define CONCAT(x, y) x ## y
#define EXPAND(x, y) CONCAT(x, y)
#define PAD(size) char EXPAND(pad, __LINE__)[size]

// forward declaration
#define FWDDECL struct

typedef unsigned Address;
typedef unsigned Count;
typedef unsigned long Id;
typedef unsigned char* Packet;
typedef int Socket;
typedef unsigned long TickCount;

enum struct Country : UINT8
{
    Light,
    Fury,
    Neutral
};

enum EquipmentSlot
{
    Helmet,     //0x1C0
    UpperArmor, //0x1C4
    LowerArmor, //0x1C8
    Gloves,     //0x1CC
    Boots,      //0x1D0
    Weapon,     //0x1D4
    Shield,     //0x1D8
    Cloak,      //0x1DC
    Ring1,      //0x1DC
    Ring2,      //0x1E0
    Loop1,      //0x1E4
    Loop2,      //0x1E8
    Amulet,     //0x1EC
    Vehicle,    //0x1F0
};

enum struct Family : UINT8
{
    Human,
    Elf,
    Vail,
    Deatheater
};

enum struct Grow : UINT8
{
    Easy,
    Normal,
    Hard,
    Ultimate
};

enum struct Job : UINT8
{
    AttackFighter,
    DefenseFighter,
    PatrolRogue,
    ShootRogue,
    AttackMage,
    DefenseMage
};

enum struct ItemType : UINT8
{
    Gold = 26,
    Gem = 30,
    Vehicle = 42
};

enum struct Race : UINT8
{
    Human,
    Elf,
    Light,
    DeathEater,
    Vail,
    Fury,
    Neutral
};

enum struct Sex : UINT8
{
    Male,
    Female
};
