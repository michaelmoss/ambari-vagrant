#!/usr/bin/env bash

cp /vagrant/hosts /etc/hosts
cp /vagrant/resolv.conf /etc/resolv.conf
yum install ntp -y
service ntpd start

# install tools necessary to build Ambari
yum install git -y
yum install rpm-build -y
wget http://nodejs.org/dist/v0.10.15/node-v0.10.15-linux-x64.tar.gz
tar zxvf node-v0.10.15-linux-x64.tar.gz
mv node-v0.10.15-linux-x64 /usr/share/node
/usr/share/node/bin/npm install -g brunch
wget --no-check-certificate http://pypi.python.org/packages/2.6/s/setuptools/setuptools-0.6c11-py2.6.egg
sh setuptools-0.6c11-py2.6.egg
wget http://www.bizdirusa.com/mirrors/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz 
tar zxvf apache-maven-3.0.5-bin.tar.gz
mv apache-maven-3.0.5 /usr/share/maven
yum install java-1.6.0-openjdk-devel -y

# make maven and node available in PATH
echo 'pathmunge /usr/share/node/bin' > /etc/profile.d/node.sh
chmod +x /etc/profile.d/node.sh
echo 'pathmunge /usr/share/maven/bin' > /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh

rm -rf $HOME
cp /vagrant/README ~

echo "Setting up environment..."
cat >> /home/vagrant/.bashrc <<EOF
export JAVA_HOME=/usr/jdk64/jdk1.7.0_45
export HADOOP_HOME=/usr/lib/hadoop
export ZOOKEEPER_HOME=/usr/lib/zookeeper
export PATH=$PATH:/usr/lib/accumulo/bin
EOF
export JAVA_HOME=/usr/jdk64/jdk1.7.0_45
export HADOOP_HOME=/usr/lib/hadoop
export ZOOKEEPER_HOME=/usr/lib/zookeeper
export PATH=$PATH:/usr/lib/accumulo/bin


# install accumulo
curl -O -L -s http://www.carfab.com/apachesoftware/accumulo/1.6.1/accumulo-1.6.1-bin.tar.gz
tar xvzf accumulo-1.6.1-bin.tar.gz
mv accumulo-1.6.1 /usr/lib/accumulo
sudo chown -R vagrant:vagrant /usr/lib/accumulo

echo "Configuring Accumulo..."
cp /usr/lib/accumulo/conf/examples/1GB/standalone/* /usr/lib/accumulo/conf/
cat > /usr/lib/accumulo/conf/masters <<EOF
c6401.ambari.apache.org
EOF
cat > /usr/lib/accumulo/conf/slaves <<EOF
c6401.ambari.apache.org
EOF
sed -i 's/>secret</>dev</' /usr/lib/accumulo/conf/accumulo-site.xml



echo 'Ambari Development VM has been set up! Enjoy!'
