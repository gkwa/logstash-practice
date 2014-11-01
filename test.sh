logstash_ver=1.4.2


set -o errexit

basename=logstash-$logstash_ver
zip=logstash-$logstash_ver.tar.gz
wget -ncv https://download.elasticsearch.org/logstash/logstash/$zip
tar xf $zip

cat << EOF >$basename/logstash-simple.conf
input {
    stdin {}
}
output {
    stdout {
        codec => rubydebug
    }
    elasticsearch {
        host => localhost
        protocol => http
    }
}
EOF

cd $basename
bin/logstash -f logstash-simple.conf
