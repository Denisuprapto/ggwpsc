## Installation

  ```html
  sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && sudo apt install -y wget && sudo apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/Denisuprapto/ggwpsc/main/setup.sh && chmod +x setup.sh && ./setup.sh && rm -rf ./setup.sh

  ```
