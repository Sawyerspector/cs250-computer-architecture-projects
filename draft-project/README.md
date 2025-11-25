# HW3 — C Programming

This folder contains C implementations from CS250 Homework 3.

## sequence.c
Computes S_N = N^3 − 3 for a command-line integer N (≥0). Returns EXIT_SUCCESS and matches all autograder tests.

## recurse.c
Recursive implementation of f(N) = 2(N+1) + 3*f(N−1) + 9 with base case f(0)=2. Required strict recursion (non-recursive versions penalized).

## draft.c
Reads an input file describing NBA draft picks (name, college, team). Builds a dynamically allocated linked list, sorts entries alphabetically by college and by draft position, and prints formatted results. Memory-safe (validated via valgrind).
