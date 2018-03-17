#!/bin/sh
dpkg-deb -e littlex_1.3.7.deb
dpkg-deb -x littlex_1.3.7.deb ./
exit 0