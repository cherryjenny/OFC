import { LightningElement, track, api} from 'lwc';
import LightningModal from 'lightning/modal';

export default class Gallery extends LightningElement {
    @track pictures = [
        { id: 1, url: 'https://serveq.co.kr/web/product/big/202308/9d5f16fb46e9dc1b53b69ffa5a4744ca.jpg', description: '크로와상 생지 60g' },
        { id: 2, url: 'https://serveq.co.kr/web/product/big/202308/994e6fdca428d801ebee27e8ce292a0d.jpg', description: '애플파이 냉동생지 75g' },
        { id: 3, url: 'https://serveq.co.kr/web/product/big/202308/d06e52885954c346e8bbca0826ab0c0a.jpg', description: '페이스트리 소금빵 68g' }, 
        { id: 4, url: 'https://serveq.co.kr/web/product/big/202311/0b0e49634e3671c437b9afa51bc44834.jpg', description: '미니 메이플 피칸 플레이트 42g' },
        { id: 5, url: 'https://serveq.co.kr/web/product/big/202308/3c1b937150b54f6e6009dfae421a1d14.jpg', description: '딸기파이 냉동생지 75g' },
        { id: 6, url: 'https://serveq.co.kr/web/product/big/202308/b41e29a1642429ee1ac81bdc19e6a4a0.jpg', description: '초코헤이즐넛스콘 100g' },
        { id: 7, url: 'https://serveq.co.kr/web/product/big/202308/6899769cac9afb1c7fc0239609d4dbba.jpg', description: '밀크 식빵 도우 200g' },
        { id: 8, url: 'https://serveq.co.kr/web/product/big/202308/97fbf0b81124d1c2ed397ee274042a1a.jpg', description: '콘식빵 도우 200g' },
        { id: 9, url: 'https://serveq.co.kr/web/product/big/202308/bcf66746728cfc57f14d0f63db22cd5b.jpg', description: 'AOP 샤랑트푸아트 버터 크로와상 75g' },
        { id: 10, url: 'https://serveq.co.kr/web/product/big/202308/c9b0fe67cac5d2c67690d54ccc8d2f60.jpg', description: '사각시트페이스트리(S) 4.5mm 60g' },
        { id: 11, url: 'https://serveq.co.kr/web/product/big/202308/a806129cb03263f9342bb9c1ba9137c0.jpg', description: '단과자볼도우 50g' },
        { id: 12, url: 'https://serveq.co.kr/web/product/big/202308/51bf4356a91f7235c9e1a1a1744380cb.jpg', description: '버터식빵도우 200g' },
        { id: 13, url: 'https://serveq.co.kr/web/product/big/202308/9df64fa24ba6a105ea03202101983fc0.jpg', description: '얼그레이스콘 100g' },
        { id: 14, url: 'https://serveq.co.kr/web/product/big/202308/12c35d0e5a0b854f46ca6abebf801e79.jpg', description: '크랜베리스콘 100g' }
        // 여기에 더 많은 사진을 추가할 수 있습니다.
    ];
    
    @track selectedImageUrl = null;
    @track selectedDescription = null;
  
    handlePictureClick(event) {
        this.selectedImageUrl = event.currentTarget.dataset.url;
        this.selectedDescription = event.currentTarget.dataset.description;
    }

    handleCloseInfo() {
        this.selectedImageUrl = null;
        this.selectedDescription = null;
    }
}

export class MyModal extends LightningModal {
    @api content;

    handleOkay() {
        this.close('okay');
    }
}