# Documentation : https://www.jenkins.io/doc/book/installing/linux/

#check Ubuntu version
lsb_release -a

#update packages and install JDK
sudo apt install default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt upgrade
#install jenkins
sudo apt install jenkins
# You will get an error , solution is : https://stackoverflow.com/a/72344097/21975715
#Then repeat line number 10 and 13

#Allow ports
sudo ufw allow 8080

#Start Jenkins instance
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
sudo -s

#Check initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword




