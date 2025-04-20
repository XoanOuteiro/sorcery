#!/bin/bash
echo -e "--[回廊]--\n"

curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | ncat -nlvp 8009
