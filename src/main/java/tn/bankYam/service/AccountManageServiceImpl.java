package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Accounty;
import tn.bankYam.dto.Membery;
import tn.bankYam.dto.Product;
import tn.bankYam.mapper.AccountManageMapper;

import java.sql.Date;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AccountManageServiceImpl implements AccountManageService{

    @Autowired
    private AccountManageMapper accountManageMapper;

    @Autowired
    private AccountyService accountyService;

    @Override
    public List<Accounty> selectAcList(Membery membery){
        return accountManageMapper.selectAcList(membery);
    }

    @Override
    public List<Accounty> selectAcXList(Membery membery){
        return accountManageMapper.selectAcXList(membery);
    }

    @Override
    public HashMap<String, Object> forMapIdId(long ac_seq, long mb_seq){
        HashMap<String, Object> forAcMap = new HashMap<>();
        forAcMap.put("ac_seq", ac_seq);
        forAcMap.put("mb_seq", mb_seq);
        return forAcMap;
    }

    @Override
    public List<Accounty> checkAcBeforeMain(long mb_seq){
        return accountManageMapper.checkAcBeforeMain(mb_seq);
    }

    @Override
    public Accounty checkAc(HashMap<String, Object> hashMap){
        return accountManageMapper.checkAc(hashMap);
    }

    @Override
    public void updateAcNewMain(Accounty accounty){
        accountManageMapper.updateAcNewMain(accounty);
    }

    @Override
    public void updateAcBeforeMain(Accounty accounty){
        accountManageMapper.updateAcBeforeMain(accounty);
    }

    @Override
    public void updateAcName(Accounty accounty){
        accountManageMapper.updateAcName(accounty);
    }

    @Override
    public Accounty checkAcOnly(long ac_seq){
        return accountManageMapper.checkAcOnly(ac_seq);
    }

    // Mybatis 넣어줄 맵 만들기(계좌Seq, 계좌상태) no mapper
    @Override
    public HashMap<String, Object> forMapIdSt(long ac_seq, String cat){
        HashMap<String, Object> forAcMap = new HashMap<>();
        forAcMap.put("ac_seq", ac_seq);
        forAcMap.put("cat", cat);
        return forAcMap;
    }

    @Override
    public void updateAcStatus(HashMap<String, Object> hashMap){
        accountManageMapper.updateAcStatus(hashMap);
    }

    @Override
    public void updateAcPwdCheck(long ac_seq){
        accountManageMapper.updateAcPwdCheck(ac_seq);
    }

    @Override
    public void updateAcPwdWrong(long ac_seq){
        accountManageMapper.updateAcPwdWrong(ac_seq);
    }

    @Override
    public void updateAcPs(Accounty accounty){
        accountManageMapper.updateAcPs(accounty);
    }

    // 이자일 용 리스트 만들기 no mapper
    @Override
    public List<Object> getDMY(){
        // 오늘 기준 일, 월, 년 불러오기
        int nowDay = LocalDate.now().getDayOfMonth();   // 오늘
        int nowMonth = LocalDate.now().getMonthValue(); // 이번달
        int nowYear = LocalDate.now().getYear();    // 올해

        int nextMonth = nowMonth+1; // 다음달
        if(nextMonth > 12){nextMonth=1;}    // 다음달이 해 지났으면 1월
        int nNextMonth = nextMonth +1;  // 다다음달
        if(nNextMonth > 12){nNextMonth=1;}  // 다다음달이 해 지났으면 1월

        int nextYear = nowYear + 1; // 내년
        int nNextYear = nowYear + 2;    // 내후년

        // 다음달, 다다음달, 내년 Map 만들기
        HashMap<String, Integer> getMY = new HashMap<>();
        getMY.put("rD", nowDay);
        getMY.put("rM", nowMonth);
        getMY.put("nM", nextMonth);
        getMY.put("nNM", nNextMonth);
        getMY.put("rY", nowYear);
        getMY.put("nY", nextYear);
        getMY.put("nNY", nNextYear);

        // 날짜 리스트 만들고 오늘 날 기점으로 리스트 만들기
        List<Integer> rowDay = new ArrayList<>(Arrays.asList(1,5,10,15,20,25)); // 기준 이자 지급일들
        List<Integer> getDay = rowDay.stream().filter(e -> e > nowDay).collect(Collectors.toList());    // 초기 할당 리스트
        List<Integer> forDay = rowDay.stream().filter(e -> e <= nowDay).collect(Collectors.toList());   // 오늘 대비 할당 리스트

        if(forDay != null){
            for(Integer day : forDay){
                getDay.add(day);
            }
        }

        // 컨트롤러로 보내줄 (오늘일자, 날짜 순서 재배치 리스트, 월/년 맵)
        List<Object> sendList = Arrays.asList(nowDay, getDay, getMY);

        return sendList;
    }

    @Override
    public List<Accounty> myAllAcBySeq(long mb_seq){
        return accountManageMapper.myAllAcBySeq(mb_seq);
    }

    // 가장 최근 금리 적용된 예금 상품 이름들 가져올 리스트 no mapper
    @Override
    public List<Product> forRecentPdList(){
        List<Product> forPdList = new ArrayList<>();
        List<String> forRecentPd = accountyService.findDepositPd();
        for(String pdName : forRecentPd){
            Product product = accountyService.findDepositPdVal(pdName);
            forPdList.add(product);
        }
        return forPdList;
    }

    // 가장 최근 금리 적용된 적금 상품 이름들 가져올 리스트 no mapper
    @Override
    public List<Product> forRecentPdList2(){
        List<Product> forPdList = new ArrayList<>();
        List<String> forRecentPd = accountyService.findSavingPd();
        for(String pdName : forRecentPd){
            Product product = accountyService.findDepositPdVal(pdName);
            forPdList.add(product);
        }
        return forPdList;
    }

    // Select된 상품 이름 받아서 (새 별칭명 + 기존 별칭명들) 담은 리스트
    @Override
    public List<String> forAcNames(List<Accounty> allAc, String pdName){
        List<String> forAcNames = new ArrayList<>();

        int size = allAc.size();
        int num = size + 1;

        // 가장 최근 금리 적용된 상품 이름으로 별칭 만들기
        String forName = pdName + num;
        int i = 0;

        // 유효성 검사 및 네임 넘버링
        if(size > 1) {  // 2개 이상일 때 이름 체크해서 뒤에 숫자 넣어주기 -> 겹치는 이름 없을 때 까지 숫자 증가시킴!
            while (i > size) {
                if (forName.equals(allAc.get(i).getAc_name())) {
                    num += 1;
                    forName = pdName + num;
                    i = 0;
                }
                i++;
            }
        }else{  // 1개 일때
            if (forName.equals(allAc.get(0).getAc_name())) {
                num += 1;
                forName = pdName + num;
            }
        }
        System.out.println(forName);
        forAcNames.add(forName);    // index 0 -> 새로 설정할 이름

        // 기존 이름들도 넣어줌 -> 새로 설정할 경우 비교해줄 용도
        for(Accounty accounty : allAc){
            forAcNames.add(accounty.getAc_name());
        }

        return forAcNames;
    }

    // 날짜 재편집(<String>yyyy-(m)m-(d)d -> <sql.Date>yyyy-mm-dd) no mapper
    @Override
    public Date modifyData(String dateStr){
        String[] splitDate = dateStr.split("-");
        String getDate = "";

        //받아온 데이터 가공
        for(String str : splitDate){
            int check = Integer.parseInt(str);
            if(check < 10){
                str = "0" + str;
            }
            getDate = getDate + "-" + str;
        }

        getDate = getDate.substring(1,getDate.length());

        Date forSqlDate = Date.valueOf(getDate);

        return forSqlDate;
    }

    @Override
    public void insertAc(Accounty accounty){
        accountManageMapper.insertAc(accounty);
    }

    @Override
    public HashMap<String, Object> forMapIdL(long ac_seq, Long amount){
        HashMap<String, Object> forAcMap = new HashMap<>();
        forAcMap.put("ac_seq", ac_seq);
        forAcMap.put("amount", amount);
        return forAcMap;
    }

    @Override
    public void updateAcBalance(HashMap<String, Object> hashMap){
        accountManageMapper.updateAcBalance(hashMap);
    }

    @Override
    public void deleteAc(long ac_seq){
        accountManageMapper.deleteAc(ac_seq);
    }
}
