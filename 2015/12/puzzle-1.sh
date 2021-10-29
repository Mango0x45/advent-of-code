#!/usr/bin/env sh

tr -c '\-0-9' '\n' <input | grep . | paste -sd+ | bc
