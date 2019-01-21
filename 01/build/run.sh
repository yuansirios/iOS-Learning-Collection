#!/bin/bash
#✏️⚠️✅🚫💯
#cd build
#sh run.sh -a ../qingningcar-dealer -b debug -c ../package0121 -u YES
#sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/

#请输入参数 -a [工程路径] -b [debug|test|uat|pt|release] -c [安装包输出路径] -u [是否需要上传蒲公英YES||NO]

while getopts "a:b:c:u:" arg #选项后面的冒号表示该选项需要参数
do
    case $arg in
            a)
                projectDir=$OPTARG
                ;;
            b)
                archiveType=$OPTARG
                ;;
            c)
                packageDir=$OPTARG
                ;;
            u)
                uploadGYER=$OPTARG
            ;;
            ?)
                echo "unkonw argument"
                ;;
    esac
done

cd $( cd "$( dirname "$0"  )" && pwd  )

# 工程名+Scheme+Option
AppName="工程名称"
OPTIONS_LIST_PATH=""

#ipa、dSYM文件
IPA_NAME=""
ARCH_NAME=""

#本地存放ipa、dSYM路径
LOCAL_IPA_PATH=""
LOCAL_ARCH_PATH=""

#蒲公英
PGY_API_KEY="8373713e50********c33b812a49b" 
PGY_USER_KEY="0db58ce2f********ff79754633cfa3e"
PGY_PASSWORD="访问密码******"

#查看帮助
showHelp(){
    printf "%s\n" "⚠️请输入参数 -a [工程路径] -b [debug|test|uat|pt|release] -c [安装包输出路径] -u [是否需要上传蒲公英YES||NO]"
}

# 模式区分
# 证书、描述文件配置
setUpConfing(){
    if [ $archiveType = "release" ] ; then

    CODE_SIGN_DISTRIBUTION="iPhone Distribution: ****** technology co. LTD (*******)"
    PROVISIONING_PROFILE="******"
    OPTIONS_LIST_PATH="exportOptions/adhoc.plist"
    configType="Release"

    elif [ $archiveType = "debug" ] ; then

    CODE_SIGN_DISTRIBUTION="iPhone Developer: ******* (*******)"
    PROVISIONING_PROFILE="*******"
    OPTIONS_LIST_PATH="exportOptions/dev.plist"
    configType="Debug"

    elif [ $archiveType = "test" ] ; then

    CODE_SIGN_DISTRIBUTION="iPhone Developer: ******* (*******)"
    PROVISIONING_PROFILE="*******"
    OPTIONS_LIST_PATH="exportOptions/dev.plist"
    configType="Test"

    elif [ $archiveType = "uat" ] ; then

    CODE_SIGN_DISTRIBUTION="iPhone Developer: ******* (*******)"
    PROVISIONING_PROFILE="*******"
    OPTIONS_LIST_PATH="exportOptions/dev.plist"
    configType="Uat"

	elif [ $archiveType = "pt" ] ; then

    CODE_SIGN_DISTRIBUTION="iPhone Developer: ******* (*******)"
    PROVISIONING_PROFILE="*******"
    OPTIONS_LIST_PATH="exportOptions/dev.plist"
    configType="Pt"

    fi

    printf "%s\n" "✏️~~~~~~~~执行 (archiveType): $archiveType 脚本~~~~~~~~"
}

setUpName(){


    project_infoplist_path="${projectDir}/${AppName}/Info.plist"

    #取版本号
    bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}")

    #取build值
    bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}")


    DATE="$(date +%H%M%S)"
    IPA_NAME="${AppName}_build${bundleVersion}_${DATE}_${archiveType}.ipa"
    ARCH_NAME="${AppName}_build${bundleVersion}_${DATE}_${archiveType}.xcarchive"


    LOCAL_IPA_PATH="${packageDir}/${IPA_NAME}"
    LOCAL_ARCH_PATH="${packageDir}/${ARCH_NAME}"
}

uploadToPGY(){
    # 上传蒲公英
    if [ $uploadGYER = YES ]; then
        echo "✏️~~~~~~~~~~~~~~~~上传ipa到蒲公英~~~~~~~~~~~~~~~~~~~"
        curl -F "file=@$packageDir/$IPA_NAME/Apps/$AppName.ipa" \
        -F "uKey=${PGY_USER_KEY}" \
        -F "_api_key=${PGY_API_KEY}" \
        -F "password=${PGY_PASSWORD}" \
        https://www.pgyer.com/apiv1/app/upload
     
        if [ $? = 0 ]
        then
        echo -e "\n"
            echo "💯~~~~~~~~~~~~~~~~上传蒲公英成功~~~~~~~~~~~~~~~~~~~"
        else
        echo -e "\n"
            echo "🚫~~~~~~~~~~~~~~~~上传蒲公英失败~~~~~~~~~~~~~~~~~~~"
        fi
    else
        echo "⚠️~~~~~~~~~~~~~~~~不选择上传蒲公英~~~~~~~~~~~~~~~~~~~"
    fi
}

printf "%s\n" "✏️入参 -a (projectDir): $projectDir"
printf "%s\n" "✏️入参 -b (archiveType): $archiveType"
printf "%s\n" "✏️入参 -c (packageDir): $packageDir"
printf "%s\n" "✏️入参 -c (uploadGYER): $uploadGYER"

if [ -z "$projectDir" -o ! -d "$projectDir" ]; then
    printf "%s\n" "✏️~~~~~~~~请输入: $projectDir ~~~~~~~~"
    showHelp
    exit -1
fi

if [ -z "$archiveType" ]; then
    printf "%s\n" "✏️~~~~~~~~请输入: $archiveType ~~~~~~~~"
    showHelp
    exit -1
fi

if [ -z "$packageDir" ]; then
    printf "%s\n" "✏️~~~~~~~~请输入: $packageDir ~~~~~~~~"
    showHelp
    exit -1
fi

if [ -z "$uploadGYER" ]; then
    printf "%s\n" "✏️~~~~~~~~请输入: $uploadGYER ~~~~~~~~"
    showHelp
    exit -1
fi

printf "%s\n" "✏️~~~~~~~~build.sh start~~~~~~~~~~"

#开始时间
beginTime=`date +%s`

setUpConfing
setUpName

#创建路径
rm -rf ${packageDir}
mkdir -p ${packageDir}

printf "%s\n" "✏️~~~~~~~~Xcode Clean~~~~~~~~~~"

xcodebuild \
-workspace "${projectDir}/${AppName}.xcworkspace" \
-scheme "${AppName}" \
-configuration "${configType}" \
clean

printf "%s\n" "✏️~~~~~~~~Xcode Archive~~~~~~~~~~"

xcodebuild \
archive \
-workspace "${projectDir}/${AppName}.xcworkspace" \
-scheme "${AppName}" \
-archivePath "${LOCAL_ARCH_PATH}" \
-configuration "${configType}"

if [ $? -eq 0 ];then

	printf "%s\n" "✏️~~~~~~~~Xcode Archive Success~~~~~~~~~~"

    xcodebuild  \
    -exportArchive \
    -exportOptionsPlist "${OPTIONS_LIST_PATH}" \
    -archivePath "${LOCAL_ARCH_PATH}" \
    -exportPath "${LOCAL_IPA_PATH}" \
    CODE_SIGN_IDENTITY "${CODE_SIGN_DISTRIBUTION}" \
    PROVISIONING_PROFILE "${PROVISIONING_PROFILE}"

    endTime=`date +%s`

    if [ $? -eq 0 ];then    
        printf "%s\n" "✅~~~~~~~~打包成功持续时间$[ endTime - beginTime ]秒~~~~~~~~"
        printf "%s\n" "💯安装包地址 $packageDir/$IPA_NAME/Apps/$AppName.ipa"
        uploadToPGY
    else
        printf "%s\n" "🚫~~~~~~~~打包失败持续时间$[ endTime - beginTime ]秒~~~~~~~~"
    fi

else
    endTime=`date +%s`
    printf "%s\n" "🚫~~~~~~~~Xcode Archive Failed 持续时间$[ endTime - beginTime ]秒~~~~~~~~"
fi
