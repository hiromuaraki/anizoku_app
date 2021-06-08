jQuery(function() {
	//クリックしたときのファンクションをまとめて指定
	jQuery('.watch-list').click(function() {
		var index = jQuery('.watch-list').index(this);
		// コントローラへindexを渡す
		$.ajax({
			url: "/users/my_page",
			type: "GET",
			data: {status : index},
			datatype: "json",
			success: function(data){
				//成功時の処理
			},
			error: function(data) {
				console.log('error');
				alert("URLが不正、もしくはこのURLには対応していません。");
		}
		
		});

	});

	jQuery('.review-list').click(function() {
		var index = jQuery('.review-list').index(this);
		// コントローラへindexを渡す
		$.ajax({
			url: "/users/reviews",
			type: "GET",
			data: {rate : index},
			datatype: "json",
			success: function(data){
				//成功時の処理
			},
			error: function(data) {
				console.log('error');
				alert("URLが不正、もしくはこのURLには対応していません。");
		}
		
		});

	});

	jQuery('.my-list').click(function() {
		// コントローラへindexを渡す
		$.ajax({
			url: "/users/mylists/index",
			type: "GET",
			datatype: "json",
			success: function(data){
				//成功時の処理
			},
			error: function(data) {
				console.log('error');
				alert("URLが不正、もしくはこのURLには対応していません。");
		}
		
		});

	});

	jQuery('.konki-list').click(function() {
		// コントローラへindexを渡す
		$.ajax({
			url: "/users/this_term_list",
			type: "GET",
			datatype: "json",
			success: function(data){
				//成功時の処理
			},
			error: function(data) {
				console.log('error');
				alert("URLが不正、もしくはこのURLには対応していません。");
		}
		
		});

	});

	jQuery('.zenki-list').click(function() {
		// コントローラへindexを渡す
		$.ajax({
			url: "/users/first_term_list",
			type: "GET",
			datatype: "json",
			success: function(data){
				//成功時の処理
			},
			error: function(data) {
				console.log('error');
				alert("URLが不正、もしくはこのURLには対応していません。");
		}
		
		});

	});

});
