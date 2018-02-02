# clean-up
rm -rf working

# clone repo
git clone git@github.com:dreamhouseapp/dreamhouse-sfdx.git working

# open working director
cd working

# checkout a new branch
git checkout -b decomp

# make new force-app folders
mkdir force-app/ui
mkdir force-app/bl
mkdir force-app/schema
mkdir force-app/perms

# move folders into new structure
mv -f force-app/main/default/applications force-app/ui/
mv -f force-app/main/default/aura force-app/ui/
mv -f force-app/main/default/contentassets force-app/ui/
mv -f force-app/main/default/flexipages force-app/ui/
mv -f force-app/main/default/layouts force-app/ui/
mv -f force-app/main/default/pages force-app/ui/
mv -f force-app/main/default/quickActions force-app/ui/
mv -f force-app/main/default/staticresources force-app/ui/
mv -f force-app/main/default/tabs force-app/ui/
mv -f force-app/main/default/classes force-app/bl/
mv -f force-app/main/default/flows force-app/bl/
mv -f force-app/main/default/triggers force-app/bl/
mv -f force-app/main/default/remoteSiteSettings force-app/bl/
mv -f force-app/main/default/objects force-app/schema/
mv -f force-app/main/default/permissionsets force-app/perms/

# grab a veresion of Property__c that's been updated to split ui from schema
mkdir force-app/ui/objects
mkdir force-app/ui/objects/Property__c
cp ../assets/decomp3/force-app/ui/objects/Property__c/Property__c.object-meta.xml force-app/ui/objects/Property__c
cp ../assets/decomp3/force-app/schema/objects/Property__c/Property__c.object-meta.xml force-app/schema/objects/Property__c

# remove old folder
rm -rf force-app/main
sfdx waw:project:pdir:delete -p force-app

# create new scratch org
sfdx force:org:create -s -f config/project-scratch-def.json -a decomporg1

# add schema to sfdx-projects
sfdx waw:project:pdir:create -p force-app/schema -d

# push source
sfdx force:source:push

# add bl to sfdx-projects
sfdx waw:project:pdir:create -p force-app/bl -d

# push source
sfdx force:source:push

# add ui to sfdx-projects
sfdx waw:project:pdir:create -p force-app/ui -d

# push source
sfdx force:source:push

# add perms to sfdx-projects
sfdx waw:project:pdir:create -p force-app/perms -d

# push source
sfdx force:source:push

# assign permset
sfdx force:user:permset:assign -n dreamhouse

# import data
sfdx force:data:tree:import -p ../data/sample-data-plan.json

# create a second scratch org
sfdx force:org:create -s -f config/project-scratch-def.json -a decomporg2

# push source
sfdx force:source:push

# assign permset
sfdx force:user:permset:assign -n dreamhouse

# import data
sfdx force:data:tree:import -p ../data/sample-data-plan.json