# bash-pls-pull

I had several wordpress sites that they had a plugin that had to be updated ocasionally, but because their DevOps sucked I had to come up with my own custom solution. So I wrote this script that's practically updating the repository code in several projects matched by pattern.

In my case every project root had the pattern "-staging-", so doing this for ~20 websites manually..... NO! 😡
Maybe someone will find this useful 😄

# Installation
```
git clone https://github.com/deko96/bash-pls-pull
# OR using SSH
git clone git@github.com:deko96/bash-pls-pull.git
cd bash-pls-pull
chmod +x pls-pull.sh
```

# Usage
```
./pls-pull.sh WWWROOT PATTERN [SUBDIR]
```

Arguments description
- **WWWROOT** - Root path where your projects are located
- **PATTERN** - Pattern which should be matched in the output of the directory listing in **$WWWROOT**
- **SUBDIR** (optional) - If you need to make a pull inside a subdirectory of the main document root which would be a directory matched by **$PATTERN**, then you can use this argument.

Examples:
```
ls -al /var/www/html
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:16 demo/
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:15 demo-staging/
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:16 demo2/
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:16 demo2-staging/
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:16 demo3/
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:16 demo4/
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:16 demo5/
drwxr-xr-x   2 deko96  staff   64 Nov 13 17:16 demo5-staging/
```
As you can see I have 3 websites matching the "staging" pattern, and I want to run **git pull** inside each staging directory, so instead of doing it manually
```
./pls-pull.sh /var/www/html staging
```

What if.. I these folders were wordpress websites, and I had to update a particular plugin used between several staging websites? No problem 😎

```
./pls-pull.sh /var/www/html staging wp-content/plugins/my-slick-plugin
```

Voila! 🥳

# Notes
- The script was made and tested on AMI Linux Distro, should work on CentOS as well but you'll never know unless you try it? 😂
- I suppose the error handling can be improved, but on the other side this is just a simple tool and if you use it right, it will do the job 😁

If you have some weird bug or got any suggestion for the future of this script, don't be ashamed to create new issue 😊

# Cheers 🍻
