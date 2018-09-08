#!/usr/bin/expect

# execute using:
# ./pushtoserver.sh <server ip> <server user> <server password> <gitlab user> <gitlab password>

set ip [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]
set usergitlab [lindex $argv 3]
set passwordgitlab [lindex $argv 4]
spawn ssh $user@$ip

# login in case you are not using ssh
expect {
    "password:"    { send "$password\r" }
    timeout        { exit 1 }
}
# end of login

sleep 3
# set the path to your project
exp_send "cd /path/to/project/\r"

exp_send "git pull\r"
expect {
    "Username for 'https://gitlab.com':" { send "$usergitlab\r" }
    timeout        { exit 1 }
}
expect {
    "@gitlab.com':" { send "$passwordgitlab\r" }
    timeout        { exit 1 }
}
sleep 3
exp_send "python manage.py collectstatic\r"
expect {
    "Type 'yes' to continue, or 'no' to cancel:" { send "yes\r" }
    timeout        { exit 1 }
}
sleep 3
# set your gunicorn instance of your project (Example: gunicorn1)
exp_send "service gunicorn1 restart\r"

sleep 3
exp_send "service nginx restart\r"
sleep 3
exp_send "exit\r"
interact

