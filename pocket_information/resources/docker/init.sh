#!/bin/sh

if ls /app/priv/ca_certificates/*.cer >/dev/null 2>&1; then
  for file in `ls /app/priv/ca_certificates/*.cer`; do
    cat $file >> /app/priv/ca_certificates/castore.pem
	  echo -e "\r" >> /app/priv/ca_certificates/castore.pem
  done
fi

export CASTORE_PATH=/app/priv/ca_certificates/castore.pem
export PUBLIC_CERT_DEPOSITS_PATH=/app/priv/deposits_certificates/public.cer
export PRIVATE_KEY_DEPOSITS_PATH=/app/priv/deposits_certificates/private.key
export PASSPHRASE_PRIV_CERT_DEPOSITS=`cat /app/priv/deposits_certificates/passphrase.pass`

export DB_PUBLIC_CERTIFICATE=/percona/priv/public.pem
export DB_PRIVATE_CERTIFICATE=/percona/priv/privatekey.pem
export DB_CASTORE=/percona/priv/ca.pem

exec /app/rel/pocket_information/bin/pocket_information foreground