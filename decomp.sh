# clean-up
rm -rf working

# clone repo
git clone git@github.com:dreamhouseapp/dreamhouse-sfdx.git working

# open working director
cd working

# checkout a new branch
git checkout -b decomp

# make new src folders
mkdir src
mkdir src/ui
mkdir src/bl
mkdir src/schema
mkdir src/perms

# move folders into new structure
mv -f force-app/main/default/applications src/ui/
mv -f force-app/main/default/aura src/ui/
mv -f force-app/main/default/contentassets src/ui/
mv -f force-app/main/default/flexipages src/ui/
mv -f force-app/main/default/layouts src/ui/
mv -f force-app/main/default/pages src/ui/
mv -f force-app/main/default/quickActions src/ui/
mv -f force-app/main/default/staticresources src/ui/
mv -f force-app/main/default/tabs src/ui/
mv -f force-app/main/default/classes src/bl/
mv -f force-app/main/default/flows src/bl/
mv -f force-app/main/default/triggers src/bl/
mv -f force-app/main/default/remoteSiteSettings src/bl/
mv -f force-app/main/default/objects src/schema/
mv -f force-app/main/default/permissionsets src/perms/

# grab a veresion of Property__c that's been updated to split ui from schema
mkdir src/ui/objects
mkdir src/ui/objects/Property__c
cp ../assets/decomp3/src/ui/objects/Property__c/Property__c.object-meta.xml src/ui/objects/Property__c
cp ../assets/decomp3/src/schema/objects/Property__c/Property__c.object-meta.xml src/schema/objects/Property__c

# remove old folder
rm -rf force-app
sfdx waw:project:pdir:delete -p force-app

# create new scratch org
sfdx force:org:create -s -f config/project-scratch-def.json

# update sfdx-project.json with new source folders
# create a working src folder for anything pulled out
sfdx waw:project:pdir:create -p src/schema -d

# push source
sfdx force:source:push

# add bl to sfdx-projects
sfdx waw:project:pdir:create -p src/bl -d

# push source
sfdx force:source:push

# add ui to sfdx-projects
sfdx waw:project:pdir:create -p src/ui -d

# push source
sfdx force:source:push

# add perms to sfdx-projects
sfdx waw:project:pdir:create -p src/perms -d

# push source
sfdx force:source:push

# assign permset
sfdx force:user:permset:assign -a dreamhouse

# import data
sfdx force:data:tree:import -p ../data/sample-data-plan.json

# open scratch org
sfdx force:org:open

# create a second scratch org
sfdx force:org:create -s -f config/project-scratch-def.json

# push source
sfdx force:source:push

# assign permset
sfdx force:user:permset:assign -a dreamhouse

# import data
sfdx force:data:tree:import -p ../data/sample-data-plan.json

# open scratch org
sfdx force:org:open

# go back to root
cd ..