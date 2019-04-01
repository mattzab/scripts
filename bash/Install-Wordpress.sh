#!/bin/bash

wget wordpress.org/latest.zip
unzip latest.zip
cd wordpress
mv * ..
cd ..
rmdir wordpress
rm latest.zip
