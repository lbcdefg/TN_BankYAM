
function newPage(){
    f.submit();
}
function count(type)  {
    // 결과를 표시할 element
    const resultElement = document.getElementById('result');
    // 현재 화면에 표시된 값
    let number = $('#result').val();


    // 더하기
    if(type === 'plus1') {
      number = parseInt(number) + 10000;
    }else if(type === 'plus5')  {
      number = parseInt(number) + 50000;
    }else if(type === 'plus10')  {
        number = parseInt(number) + 100000;
    }else if(type === 'plus100')  {
        number = parseInt(number) + 1000000;
    }else if(type === 'minus'){
        number = 0;
    }
    // 결과 출력
    //resultElement.innerText = number;
    $('#result').val(number);
}