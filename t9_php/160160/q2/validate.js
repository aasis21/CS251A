
	var usr = document.getElementById("usr");
	var addr = document.getElementById("addr");
	var mail = document.getElementById("mail");
	var mob = document.getElementById("mob");
	var acct = document.getElementById("acct");
	var pwd = document.getElementById("pwd");


	document.getElementById("usr").addEventListener("input", usr_vldt);

	function usr_vldt() {
		var usr_e = document.getElementById("usr_e");
		var usr_regex = /^[a-zA-Z ]{0,20}$/;
		if (usr_regex.test(usr.value)) {
			usr_e.innerHTML = ""; // Reset the content of the message
			return 1;
		}
		else{
			usr_e.innerHTML = "Name must be in alphabets only";
			return 0;
		}
	}

	document.getElementById("addr").addEventListener("input", addr_vldt);

	function addr_vldt() {
		var addr_e = document.getElementById("addr_e");
		if (addr.value.length <= 100) {
			addr_e.innerHTML = ""; // Reset the content of the message
			return 1;
		}


        else{
			usr_e.innerHTML = "Maximum 100 characters";
			return 0;
		}
	}

	document.getElementById("mail").addEventListener("input", mail_vldt);

	function mail_vldt() {
		var mail_e = document.getElementById("mail_e");
		var mail_regex = /^[a-zA-Z]+@[a-z0-9A-Z_~\-]+\.com$/;
		if (mail_regex.test(mail.value)) {
			mail_e.innerHTML = ""; // Reset the content of the message
			return 1;
		}
		else{
			mail_e.innerHTML = "Invalid Email";
			return 0;
		}
	}


	document.getElementById("mob").addEventListener("input", mob_vldt);

	function mob_vldt() {
		var mob_e = document.getElementById("mob_e");

        var mob_regex = /^[1-9]{1}[0-9]{9}$/;
		if (mob_regex.test(mob.value)) {
			mob_e.innerHTML = ""; // Reset the content of the message
			return 1;

        }
		else{
			mob_e.innerHTML = "Invalid Mobile Number";
			return 0;
		}
	}


	document.getElementById("acct").addEventListener("input", acct_vldt);

	function acct_vldt() {
		var acct_e = document.getElementById("acct_e");
		var acct_regex = /^[0-9]{5}$/;
		if (acct_regex.test(acct.value)) {
			acct_e.innerHTML = ""; // Reset the content of the message
			return 1;
		}
		else{
			acct_e.innerHTML = "Invalid Account Number";
			return 0;

		}
	}


	document.getElementById("pwd").addEventListener("input", pwd_vldt);

	function pwd_vldt() {
		var pwd_e = document.getElementById("pwd_e");
		var pwd_regex = /^[a-zA-Z0-9]{0,20}$/;
		if (pwd_regex.test(pwd.value)) {
			pwd_e.innerHTML = ""; // Reset the content of the message
			return 1;
		}
		else{
			pwd_e.innerHTML = "Maximum 20 alphanumeric characters";
			return 0;
		}
	}


    var reg = document.getElementById("reg");
	reg.addEventListener("submit", function (event){
		var u_r = usr_vldt();
		var ad_r = addr_vldt();
		var ma_r = mail_vldt();
		var mo_r = mob_vldt();
		var ac_r = acct_vldt();
		var p_r = pwd_vldt();
		console.log(u_r,ad_r,ma_r,mo_r,ac_r,p_r)
		if(u_r && ad_r && ma_r && mo_r && ac_r && p_r){
			var f = 0;
		}
		else{
			alert("Please give Valid Input!! ");
			event.preventDefault();
		}

	}, false);
