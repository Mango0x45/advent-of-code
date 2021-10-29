#!/usr/bin/env sh

tr -c '\-0-9' '\n' <input | squash | paste -sd+ | bc
