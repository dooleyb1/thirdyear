#pragma once

//
// t1.h
// Copyright(C) 2018 dooleyb1@tcd.ie

// NB: "extern C" to avoid procedure name mangling by compiler
//

extern "C" int g;

extern "C" int _cdecl min(int, int, int);
extern "C" int _cdecl p(int, int, int, int);
extern "C" int _cdecl gcd(int, int);

// eof
