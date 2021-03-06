#!/usr/bin/env bash

rsync -a --exclude='tools/vagrant/.vagrant' /monasca-transform-source /home/vagrant/
mv /home/vagrant/monasca-transform-source /home/vagrant/monasca-transform
pushd /home/vagrant/monasca-transform
# prepare the codebase
#
# generate the sql scripts to populate the database
scripts/generate_ddl.sh
# build the zip
scripts/create_zip.sh

git config --global user.email "local.devstack.committer@hpe.com"
git config --global user.name "Local devstack committer"
git add --all
git commit -m "Local commit"

CURRENT_BRANCH=`git status | grep 'On branch' | sed 's/On branch //'`
if [ ${CURRENT_BRANCH} != 'master' ]
then
    echo Maintaining current branch ${CURRENT_BRANCH}
    # set the branch to what we're using in local.conf
    if [[ -z `grep ${CURRENT_BRANCH} /home/vagrant/devstack/local.conf` ]]; then
        sed -i "s/enable_plugin monasca-transform \/home\/vagrant\/monasca-transform//g" /home/vagrant/devstack/local.conf
        sed -i "s/# END DEVSTACK LOCAL.CONF CONTENTS//g" /home/vagrant/devstack/local.conf
        printf "enable_plugin monasca-transform /home/vagrant/monasca-transform ${CURRENT_BRANCH}\n" >> /home/vagrant/devstack/local.conf
        printf "# END DEVSTACK LOCAL.CONF CONTENTS" >> /home/vagrant/devstack/local.conf
    fi
fi

popd
