#!/bin/bash

func() { echo $* || echo $*; }
func "Hello" "World"
