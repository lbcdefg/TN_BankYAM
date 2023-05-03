function checkTrSearchAjax(){
    var tr_ac_seq = document.getElementById('tr_ac_seq').value;
    var tr_type = document.getElementById('tr_type').value;
    var tr_other_accnum = document.getElementById('tr_other_accnum').value;
    var tr_other_bank = document.getElementById('tr_other_bank').value;
    var tr_date = document.getElementById('tr_date').value;
    $.ajax({
        url:"trListSearch",
        type:"GET",
        data:{tr_ac_seq:tr_ac_seq, tr_date:tr_date, tr_type:tr_type, tr_other_accnum: tr_other_accnum, tr_other_bank:tr_other_bank},
        success: function(data){
            var dataChange = JSON.stringify(data);
            console.log(data);
            $("#ajax-try").text(data.tr_type);
            $("#ajax-try").text(data.tr_ac_seq);
            $("#ajax-try").text(data.tr_other_accnum);
            $("#ajax-try").text(data.tr_other_bank);
            $("#ajax-try").text(data.tr_date);
        },
        error: function(error){
            console.log("error:"+error);
        }
    });
}