$(document).ready(function(){
  let timeout;

  function resetTimer() {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      let swalTimeout = setTimeout(() => {
        Swal.close();  // 10초 후에 Swal 알림 닫기
        window.location.href = '/';  // 메인 페이지로 이동
      }, 10000);  // 10초 설정

      Swal.fire({
        title: '1분 동안 활동이 없어 메인 페이지로 이동합니다.',
        text: '이동하지 않으려면 확인 버튼을 눌러주세요.',
        showCancelButton: false,
        confirmButtonText: '확인'
      }).then((result) => {
        clearTimeout(swalTimeout);  // Swal 알림에 대한 타임아웃 취소

        if (result.isConfirmed) {
          resetTimer();  // 확인 버튼을 눌렀을 때 타이머 리셋
        } else {
          window.location.href = '/';  // 취소 버튼을 누르거나 다른 방법으로 닫았을 때 메인 페이지로 이동
        }
      });
    }, 60000);  // 1분
  }

  // 페이지에서 마우스나 키보드 이벤트가 발생하면 타이머를 리셋
  $(document).on('mousemove', resetTimer);
  $(document).on('keydown', resetTimer);

  // 초기 타이머 설정
  resetTimer();
});
