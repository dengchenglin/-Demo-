var ghshare_config = {
		share_id : 0,
		title:'',
		img:'',
		uid : 0,
		url : '',
		text : '',
		icon_size:32,
		rnd:''
	}
var ghshare_inited=0;
var ghshare_reflux_id = 0;
var ghshare_reflux_uid = 0;
var ghshare_reflux_webid='';
var ghshare_apptype=''; //链接中加入App端类型: android/ios

//考虑到初始化失败的问题，最终还是决定使用share_id
function ghshare_init(share_id,links,icon_size)
{
		
	var usearch=document.location.search;
	ghshare_config.share_id=share_id;
	ghshare_config.title=document.title;
	ghshare_config.text=document.title;
	ghshare_config.url=document.location.href;
	ghshare_config.img="";
	ghshare_apptype=ghshare_getUrlParam(usearch,"ghshare_apptype"); //链接中加入App端类型: android/ios
	var pfindex=ghshare_config.url.indexOf('#');
	if(!icon_size)
		icon_size=32;
	ghshare_config.icon_size=icon_size;
	if(pfindex>-1)
		ghshare_config.url=ghshare_config.url.substring(0, pfindex);
	ghshare_config.rnd=ghshare_rand_string(10);
	//先读取分享相关信息，如果2秒钟以后没有获取成功，则使用默认信息来生成分享代码
	jQuery.getJSON('/share/get_share_info',{ share_id:share_id },function(json){
		if(json.status==1)
		{
			if(ghshare_inited==1)
				return;
			ghshare_inited=1;
			ghshare_config.uid=json.data.uid;
			if(!empty(json.data.url))
				url=json.data.url;
			else
				url=ghshare_config.url+'';
			url=url.replace(/([\?&])ghshare_id=\d*/ig,'$1').replace(/([\?&])ghshare_uid=[^&#]*/ig,'$1').replace(/([\?&])ghshare_webid=[^&#]*/ig,'$1').replace(/([\?&])ghshare_apptype=[^&#]*/ig,'$1');
			if(!((/[\?&]$/).test(url)))
			{
				if(url.indexOf('?')>0)
					url+='&';
				else
					url+='?';
			}	
			
			if(json.data.uid>0)
			{
				url+='ghshare_id='+share_id+'&ghshare_uid='+json.data.uid+'&ghshare_apptype='+ghshare_apptype+'&ghshare_webid=GHSHAREWEBID';
				//ghshare_config.url=json.data.site_url+'spread/?r='+json.data.uid+'&go_type=url&goto='+encodeURIComponent(url);
			}
			else
			{
				url+='ghshare_id='+share_id+'&ghshare_uid='+ghshare_config.rnd+'&ghshare_apptype='+ghshare_apptype+'&ghshare_webid=GHSHAREWEBID';
				//ghshare_config.url=url;
			}
			
			ghshare_config.url=url;
			if(!empty(json.data.text))
				ghshare_config.text=json.data.text;
			if(!empty(json.data.share_title))
				ghshare_config.title=json.data.share_title;
			if(!empty(json.data.img))
				ghshare_config.img=json.data.img;	
			ghshare_setcode();
		}	
	});
	
	//如果调用初始化信息失败或者超时，要允许网页可以正常分享
	setTimeout(function(){
		if(ghshare_inited==1)
			return;
		ghshare_inited=1;
		var url=ghshare_config.url+'';
		url=url.replace(/([\?&])ghshare_id=\d*/ig,'$1').replace(/([\?&])ghshare_uid=[^&#]*/ig,'$1').replace(/([\?&])ghshare_webid=[^&#]*/ig,'$1').replace(/([\?&])ghshare_apptype=[^&#]*/ig,'$1');
		if(!((/[\?&]$/).test(url)))
		{
			if(url.indexOf('?')>0)
				url+='&';
			else
				url+='?';
		}	
		url+='ghshare_id='+share_id+'&ghshare_uid='+ghshare_config.rnd+'&ghshare_apptype='+ghshare_apptype+'&ghshare_webid=GHSHAREWEBID';
		ghshare_config.url=url;
		
		ghshare_setcode();
		
	},2000);

	var pfindex=usearch.indexOf('#');
	if(pfindex>-1)
		usearch=usearch.substring(0, pfindex);
	
	ghshare_reflux_id = ghshare_getUrlParam(usearch,"ghshare_id");
	
	ghshare_reflux_uid = ghshare_getUrlParam(usearch,"ghshare_uid");
	
	ghshare_reflux_webid = ghshare_getUrlParam(usearch,"ghshare_webid");
	if((ghshare_reflux_uid)>0&&ghshare_reflux_uid.length<10)
	{
		gh_setcookie('hom_reg_refer',document.referrer?document.referrer:'');
		gh_setcookie('hom_parent_uid',ghshare_reflux_uid,3600*24*3);
    	gh_deletecookie('hom_spread_tag');
	    gh_deletecookie('hom_red_envelope');
	    gh_deletecookie('hom_alliance_pid');
	}
	
	jQuery.ajax({
		type: "GET",
		url: "http://pstat.geihui.com/share/dostat",
		dataType: "jsonp",
		data: {
			share_id:share_id,
			share_uid:ghshare_reflux_uid,
			share_webid:ghshare_reflux_webid,
			visit_uid:ghshare_config.uid,
			source_url:document.referrer?document.referrer:'',
			share_url:document.location.href,
			app_type:ghshare_apptype
		}
	});
	
	if(ghshare_reflux_id<=0||ghshare_reflux_id!=ghshare_config.share_id)
		return;
	if(links)
	{
		jQuery.each(links,function(kk,link){
			if($(link).attr('ghshare_append_ok')==1)
				return;
			$(link).attr('ghshare_append_ok',1);
			var href=$(link).attr('href');
			if(!href)
				return;
			var href2=ghshare_append_link(href);
			if(href2!=href)
				$(link).attr('href',href);
		});
	}	
}

function ghshare_rand_string(len) {
	len = len || 32;
	var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';   
	var maxPos = $chars.length;
	var pwd = '';
	for (i = 0; i < len; i++) {
		pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
	}
	return pwd;
}

function ghshare_append_link(href)
{
	if(ghshare_reflux_id<=0||ghshare_reflux_id!=ghshare_config.share_id)
		return href;
	if(href.indexOf('javascript:')==0)
		return href;
	href=href.replace(/([\?&])share_id=\d*/ig,'$1').replace(/([\?&])share_uid=\d*/ig,'$1').replace(/([\?&])share_media=[^&#]*/ig,'$1');
	if(!((/[\?&]$/).test(href)))
	{
		if(href.indexOf('?')>0)
			href+='&';
		else
			href+='?';
	}	
	href+='share_id='+ghshare_reflux_id+'&share_uid='+ghshare_reflux_uid+'&share_media='+ghshare_reflux_webid;
	return href;
}

function ghshare_setcode()
{
	//回调地址
	var callbackUrl = "http://www.geihui.com/share/stat_share?share_id="+ghshare_config.share_id+"&share_webid=GHSHAREWEBID&share_url="+encodeURIComponent(ghshare_config.url)+"&share_uid="+(ghshare_config.uid>0?ghshare_config.uid:ghshare_config.rnd)+"&app_type="+ghshare_apptype;
	ghshare_apptype = "ios";
	//APP+PC的分享点击
	if(ghshare_apptype == "Android" || ghshare_apptype == "ios")
	{
		ghshare_config.title = ghshare_config.title.replace(/\'/g,  '\\\'');
		ghshare_config.text = ghshare_config.text.replace(/\'/g,  '\\\'');
		var json = '{"shareTitle":"'+ghshare_config.title+'","shareContent":"'+ghshare_config.text+'","sharePicUrl":"'+ghshare_config.img+'","shareUrl":"'+ghshare_config.url+'","callbackUrl":"'+callbackUrl+'"}';
		$("#btnShare").on('click',function(){
			if(ghshare_apptype == "ios")
			{
				alert(ghshare_apptype)
				performSelector(json.toString());
			}
			else
			{
				AppJsInterface.openShareDock(json);	
			}
		});
	}
	else //PC的点击
	{
		window._bd_share_config = {
			common : {
				onBeforeClick : function(cmd,config){
				
					if(ghshare_config.url && ghshare_config.text)
					{
						var bdText = ghshare_config.title;
						if(cmd == "tsina" || cmd == "tqq")
						{
							bdText = ghshare_config.text;
						}
						var share_url = ghshare_config.url+'';;
						return {bdText : bdText,bdPic : ghshare_config.img,bdComment:ghshare_config.text,bdDesc:ghshare_config.text, bdUrl : share_url.replace('GHSHAREWEBID',cmd)};
					}
				},
				onAfterClick : function(cmd){
					if(ghshare_config.share_id==0)
						return ;
					var share_url = ghshare_config.url+'';;
					jQuery.ajax({
						type: "GET",
						dataType: "jsonp",
						url: "/share/stat_share",
						data: {
							"share_webid":cmd,
							"share_id":ghshare_config.share_id,
							"share_uid":ghshare_config.uid>0?ghshare_config.uid:ghshare_config.rnd,
							"share_url":share_url.replace('GHSHAREWEBID',cmd)
						}
					});
				} 
			},
			share : [{
				bdSize : ghshare_config.icon_size
			}]
		};
		with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
	}
}

function ghshare_getUrlParam(query_string,name)
{
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
	var r = query_string.substr(1).match(reg);  //匹配目标参数
	if (r != null) return unescape(r[2]); return ''; //返回参数值
}