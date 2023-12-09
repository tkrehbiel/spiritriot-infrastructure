include config/config.sh

PROFILE=--profile default

TMPOUT=.tmp.json
STACKPARAMS=--parameters ParameterKey=stackGroup,ParameterValue=$(STACKNAME)

RESOURCENAME=--stack-name=$(STACKNAME)-resource
RESOURCETEMPLATE=./templates/resource.yaml
RESOURCEBODY=--template-body file://$(RESOURCETEMPLATE)
RESOURCECAPS=--capabilities CAPABILITY_IAM
RESOURCEPARAMSETUP=jq '. + [{"ParameterKey":"stackGroup", "ParameterValue":"$(STACKNAME)"}]' config/resource-parameters.json >$(TMPOUT)
RESOURCEPARAMS=--parameters file://$(TMPOUT)

AMPLIFYNAME=--stack-name=$(STACKNAME)-amplify
AMPLIFYTEMPLATE=./templates/amplify.yaml
AMPLIFYBODY=--template-body file://$(AMPLIFYTEMPLATE)
AMPLIFYCAPS=--capabilities CAPABILITY_IAM

BUILDNAME=--stack-name=$(STACKNAME)-build
BUILDTEMPLATE=./templates/build.yaml
BUILDBODY=--template-body file://$(BUILDTEMPLATE)
BUILDCAPS=--capabilities CAPABILITY_IAM
BUILDPARAMSETUP=jq '. + [{"ParameterKey":"stackGroup", "ParameterValue":"$(STACKNAME)"}]' config/build-parameters.json >$(TMPOUT)
BUILDPARAMS=--parameters file://$(TMPOUT)

SERVICENAME=--stack-name=$(STACKNAME)-services
SERVICETEMPLATE=./templates/service.yaml
SERVICEBODY=--template-body file://$(SERVICETEMPLATE)
SERVICECAPS=--capabilities CAPABILITY_IAM
SERVICEPARAMSETUP=jq '. + [{"ParameterKey":"stackGroup", "ParameterValue":"$(STACKNAME)"}]' config/service-parameters.json >$(TMPOUT)
SERVICEPARAMS=--parameters file://$(TMPOUT)

validate: validateresource validatebuild validateamplify
	echo done

create: createresource createbuild createamplify
	echo done

update: updateresource updatebuild updateamplify
	echo done

delete: deleteamplify deletebuild deleteresource
	echo done

VALIDATE=aws cloudformation validate-template
validateresource:
	$(VALIDATE) $(RESOURCEBODY) $(PROFILE) --no-paginate
validateamplify:
	$(VALIDATE) $(AMPLIFYBODY) $(PROFILE) --no-paginate
validatebuild:
	$(VALIDATE) $(BUILDBODY) $(PROFILE) --no-paginate
validateservice:
	$(VALIDATE) $(SERVICEBODY) $(PROFILE) --no-paginate

CREATE=aws cloudformation create-stack
createresource:
	$(RESOURCEPARAMSETUP)
	$(CREATE) $(RESOURCENAME) $(RESOURCEBODY) $(RESOURCECAPS) $(PROFILE) $(RESOURCEPARAMS)
	aws cloudformation wait stack-create-complete $(RESOURCENAME)
createamplify:
	$(CREATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYCAPS) $(PROFILE)  $(STACKPARAMS)
	aws cloudformation wait stack-create-complete $(AMPLIFYNAME)
createbuild:
	$(BUILDPARAMSETUP)
	$(CREATE) $(BUILDNAME) $(BUILDBODY) $(BUILDCAPS) $(PROFILE) $(BUILDPARAMS)
	aws cloudformation wait stack-create-complete $(BUILDNAME)
createservice:
	$(SERVICEPARAMSETUP)
	$(CREATE) $(SERVICENAME) $(SERVICEBODY) $(SERVICECAPS) $(PROFILE) $(SERVICEPARAMS)
	aws cloudformation wait stack-create-complete $(SERVICENAME)

UPDATE=aws cloudformation update-stack
updateresource:
	$(RESOURCEPARAMSETUP)
	$(UPDATE) $(RESOURCENAME) $(RESOURCEBODY) $(RESOURCECAPS) $(PROFILE) $(RESOURCEPARAMS)
	aws cloudformation wait stack-update-complete $(RESOURCENAME)
updateamplify:
	$(UPDATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYCAPS) $(PROFILE) $(STACKPARAMS)
	aws cloudformation wait stack-update-complete $(AMPLIFYNAME)
updatebuild:
	$(BUILDPARAMSETUP)
	$(UPDATE) $(BUILDNAME) $(BUILDBODY) $(BUILDCAPS) $(PROFILE) $(BUILDPARAMS)
	aws cloudformation wait stack-update-complete $(BUILDNAME)
updateservice:
	$(SERVICEPARAMSETUP)
	$(UPDATE) $(SERVICENAME) $(SERVICEBODY) $(SERVICECAPS) $(PROFILE) $(SERVICEPARAMS)

DELETE=aws cloudformation delete-stack
deleteresource:
	$(DELETE) $(RESOURCENAME) $(PROFILE) --no-paginate
	aws cloudformation wait stack-delete-complete $(RESOURCENAME)
deleteamplify:
	$(DELETE) $(AMPLIFYNAME) $(PROFILE) --no-paginate
	aws cloudformation wait stack-delete-complete $(AMPLIFYNAME)
deletebuild:
	$(DELETE) $(BUILDNAME) $(PROFILE) --no-paginate
	aws cloudformation wait stack-delete-complete $(BUILDNAME)
deleteservice:
	$(DELETE) $(SERVICENAME) $(PROFILE) --no-paginate
	aws cloudformation wait stack-delete-complete $(SERVICENAME)

outputvars:
	echo EGV_RESOURCE_EVENT_QUEUE=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-resource --query "Stacks[0].Outputs[?OutputKey=='EventQueue'].OutputValue" --output text) > .env.local
	echo EGV_RESOURCE_STATE_TABLE=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-resource --query "Stacks[0].Outputs[?OutputKey=='StateTable'].OutputValue" --output text) >> .env.local
	echo EGV_RESOURCE_JSON_BUCKET=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-build --query "Stacks[0].Outputs[?OutputKey=='JSONBucketName'].OutputValue" --output text) >> .env.local
	echo EGV_RESOURCE_SEARCH_TABLE=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-build --query "Stacks[0].Outputs[?OutputKey=='SearchTableName'].OutputValue" --output text) >>.env.local
	cat .env.local
