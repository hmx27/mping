#!/bin/bash
#####		一键Ping测试			#####
#####		Author:xiaoz.me			#####
#####		Forked:hmx27-daisuki		#####

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH

location=(
		'广州电信'
		'广州移动'
		'广州联通'
	 )
#去程/回程ip收集(finalshell软件对单一vps使用路由追踪可找到)
dnsip=(
	'121.8.132.65' 		#广州电信
	'183.233.56.165' 	#广州移动
	'120.80.120.57' 	#广州联通

)
echo '---------------------------------------------------------------------------'
function mping(){
	num=0
	#Ping次数
	pnum=$1

	#echo '---------------------------------------------------------------------------'
	echo "正在进行Ping测试20次..."
	echo "提示：测试过程需要2分钟，请耐心等待..."
	echo '---------------------------------------------------------------------------'

	#测试ip个数
	while(( $num<3 ))
	do
		ping ${dnsip[$num]} -c $pnum > /tmp/${dnsip[$num]}.txt
		echo 【${location[$num]}】 - ${dnsip[$num]}
		echo ''
		tail -2 /tmp/${dnsip[$num]}.txt
		echo '---------------------------------------------------------------------------'
		let "num++"
	done
	echo "【参数说明】"
	echo "x% packet loss: 丢包率"
	echo "min: 最低延迟"
	echo "avg: 平均延迟"
	echo "max: 最高延迟"
	echo "mdev: 平均偏差"

	echo '---------------------------------------------------------------------------'
}

function moretrace(){
	#进行路由跟踪
	echo '---------------------------------------------------------------------------'
	echo '正在测试回程路由...'
	echo '若提示 No such file or directory 报错'
	echo '请运行 wget https://raw.githubusercontent.com/hmx27-daisuki/mping/master/tracert.sh && bash tracert.sh 安装必要文件'
	echo '安装完成后再次运行 bash mping.sh 就不会报错'
	echo '---------------------------------------------------------------------------'
	echo '【广州电信】 - 121.8.132.65'
	echo ''
	/root/besttrace/besttrace -q 1 121.8.132.65
	echo '---------------------------------------------------------------------------'

	echo '【广州移动】 - 183.233.56.165'
	echo ''
	/root/besttrace/besttrace -q 1 183.233.56.165
	echo '---------------------------------------------------------------------------'
	
	echo '【广州联通】 - 120.80.120.57'
	echo ''
	/root/besttrace/besttrace -q 1 120.80.120.57
	echo '---------------------------------------------------------------------------'
	cd /root
}

mping 20
echo ''
moretrace
echo ''
echo '引用github代码1:https://github.com/helloxz/mping'
echo '引用github代码2:https://github.com/hijkpw/testrace'
echo ''
