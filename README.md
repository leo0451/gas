# MachSoft ODORMACH - Doğalgaz Kokulandırma Telemetri & SCADA Sistemi

Bu proje, doğalgaz dağıtım şirketlerine (İzmirgaz vb.) yönelik **MachSoft ODORMACH** akıllı koku enjeksiyonu telemetri ve SCADA arayüzünün güncel revizyonunu içerir.

---

## 🚀 Öne Çıkan Modüller ve Revizyonlar

### 1. 🔒 Güvenlik & Master Giriş Kapısı (Gatekeeper):
- Web adresi girildiğinde yetkisiz erişimi engellemek için **Master Güvenlik Şifresi** kapısı (`machsoft2026`).
- Doğrulamadan sonra kayıtlı `operasyon_muhendisi` oturum ekranı açılır.
- **MachSoft Kurumsal Kimliği:** Üst toolbar, giriş ekranı ve rapor antetlerinde resmi MachSoft logo entegrasyonu.

### 2. 🏢 4 İstasyonlu Dağıtım Ağı:
- Enerya ve BOTAŞ kaldırılarak yerine 4 İzmirgaz sahası tanımlanmıştır:
  1. `İZMİRGAZ SAHA 01 - Bornova`
  2. `İZMİRGAZ SAHA 02 - Torbalı`
  3. `İZMİRGAZ SAHA 03 - Aliağa`
  4. `İZMİRGAZ SAHA 04 - Pınarbaşı`

### 3. 🏭 Canlı Akış Şeması (P&ID) ve Dijital İkiz:
- **Akış Topolojisi:** Solda/altta yer alan **Yatay THT Tankı** $\rightarrow$ pano içindeki pompalara gelir $\rightarrow$ 2 pompanın sağındaki **FM (Flowmetre)** ölçüm cihazından geçer $\rightarrow$ kabinden çıkan boruyla sağdaki **Ana Doğalgaz Boru Hattı**na enjekte edilir.
- **Pompa Yönleri:** Akış okları kesinlikle **sağa doğru (`>`)** bakar.
- **Yatay Tank Seviye Noktaları:** Tank doluluk oranına göre `LL (<%10)`, `L (<%25)`, `H (>%70)` ve `HH (>%90)` sinyal lambaları anlık yanar.
- **Tank Basıncı ve Sıcaklığı:** Tank basıncı `4.0 bar`, sıcaklık opsiyonel sensör olarak `18.5 °C` gösterilir.
- **Sadeleştirme:** Büret ve karbon filtre kaldırılmış, EVC yerine FM (Flowmetre) entegre edilmiştir.

### 4. 🤖 Kestirimci Bakım & Körük Sağlık Takibi:
- Diyafram yerine **Körük** mekanizması takip edilir.
- **Körük Patlağı Teşhis Mantığı:** Pompa vuruş (strok) yaptığı halde FM ölçüm değeri 0 gr/strk seviyesine düşerse anında *"Körük Hasarı / Patlağı"* uyarısı verilir.
- **1 Yıllık Sezonluk Bakım Algoritması:** Pompaların yıllık bakım döngüsü dikkate alınarak, kış öncesi yüksek debi sezonuna girmeden önce akıllı bakım tavsiyeleri üretilir.
- **Bakım Defteri (Log):** Yapılan bakımların, değişen parçaların ve teknisyen notlarının kayıt altına alındığı dijital defter.

### 5. 👃 Koku Ölçümü Kaydı (Odorometer / Cihaz Modülü):
- Saha teknisyeninin koku ölçüm cihazından (Jerome J605, Odorometer vb.) aldığı verileri, **cihaz marka/modeli**, **son kalibrasyon tarihi** ve **ölçüm noktası** ile SCADA'ya kaydettiği modül.

### 6. 📊 4 Kategori Seçimli Grafikler:
- **Enjeksiyon Grafikleri:** Son Enjeksiyon ($gr$) ve Toplam Enjeksiyon ($gr$) eğrileri.
- **Tüketim Grafikleri:** Günlük, Haftalık ve Aylık Tüketim ($kg$) grafikleri.
- **Debi Grafiği:** Gerçek Akış ($m^3/h$) ve Tahmini Akış ($mg/m^3$).
- **Tank Grafiği:** Tank Kalan Seviye ($Lt$) zaman serisi.

### 7. ⏱️ Saat Dilimi Seçimli Tüketim Sayfası:
- Aynı günün saat dilimleri (`13:00 - 14:00`, `08:00 - 09:00` vb.) tıklanarak o saatlik dönemin tüketimi ($kg$), pompa vuruş sayısı ve ortalama debisi detaylı incelenebilir.

### 8. 📄 2 Ayrı PDF Rapor Modülü:
1. **Resmi EPDK Denetim Raporu (PDF):** Karekodlu, SHA256 onaylı resmi mevzuat tutanağı.
2. **Detaylı Periyodik Tüketim Raporu (PDF):** Pompa 1 Strok Sayısı, Pompa 2 Strok Sayısı, Toplam Strok Sayısı, Tank Başlangıç-Bitiş Seviyeleri ve **Tank Net Seviye Değişimi ($\Delta L$)** dökümü içeren teknik rapor.

---

## 💻 Çalıştırma

`c:\Users\90534\Desktop\GAS\index.html` dosyasını herhangi bir web tarayıcısında (Chrome, Edge vb.) çift tıklayarak açabilirsiniz.
- **Master Giriş Şifresi:** `machsoft2026`
- **Operasyon Mühendisi Kullanıcı Adı:** `operasyon_muhendisi`
