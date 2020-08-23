if [ -z "$deployed_environment" ]
    then 
        echo "\$deployed_environment environment variable is unset!"
        echo "Aborting deployment."
        exit
fi

if [ -z "$focusmark_productname" ]
    then 
        echo "\$focusmark_productname environment variable is unset!"
        echo "Aborting deployment."
        exit
fi

if [ -z "$target_domain" ]
    then 
        echo "\$target_domain environment variable is unset!"
        echo "Aborting deployment."
        exit
fi

if [ -z "$target_api_url" ]
    then 
        echo "\$target_api_url environment variable is unset!"
        echo "Aborting deployment."
        exit
fi

if [ -z "$target_api_key" ]
    then 
        echo "\$target_api_key environment variable is unset!"
        echo "Aborting deployment."
        exit
fi

if [ -z "$target_api_secret" ]
    then 
        echo "\$target_api_secret environment variable is unset!"
        echo "Aborting deployment."
        exit
fi

cd ..
# Deploy core AWS infrastructure
echo Deploying $focusmark_productname into the $deployed_environment environment.

echo Fetching the core AWS Infrastructure
git clone https://github.com/focusmark/aws-infrastructure.git
cd aws-infrastructure
echo Executing the AWS Infrastructure deployment
sh deploy.sh

cd ..
echo Fetching the authorization infrastructure
git clone https://github.com/focusmark/auth-infrastructure.git
cd auth-infrastructure
echo Executing the Auth Infrastructure deployment
sh deploy.sh

cd ..
echo Fetching the API infrastructure
git clone https://github.com/focusmark/api-infrastructure.git
cd api-infrastructure
echo Executing the API Infrastructure deployment
sh deploy.sh

cd ..
echo Fetching the Project Micro-Service API
git clone https://github.com/focusmark/api-project.git
cd api-project
echo Executing the Project Serverless deployment
sh deploy.sh

cd ..
echo Fetching the Task Micro-Service API
git clone https://github.com/focusmark/api-task.git
cd api-task
echo Executing the Task Serverless deployment
sh deploy.sh