# **PRODUCT REQUIREMENT DOCUMENT v1.4**

## Satu Sehat Kobar Berbasis AWCMS-Micro

### Plugin Awal: Agenda Dinkes, Surat Tugas, SPPD, Bukti Tugas, SPM, Jurnal Kunjungan, Publikasi MMC, dan Fondasi Integrasi SATUSEHAT

**Dinas Kesehatan Kabupaten Kotawaringin Barat**

**Status Dokumen	:** Draft PRD/SRS v1.4 Siap Validasi Internal  
**Tanggal	:** Juni 2026  
**Pemilik Proses Bisnis	:** Dinas Kesehatan Kabupaten Kotawaringin Barat  
**Pemilik Teknis	:**	Tim Sistem Informasi Kesehatan Dinas Kesehatan Kabupaten Kotawaringin Barat  
**Platform Teknis		:** AWCMS-Micro  
**Pola Pengembangan	:** Modular Plugin Ecosystem  
Klasifikasi **Dokumen	:**	Internal Pemerintahan / Perencanaan Produk / SPBE Kesehatan Daerah  
Disusun oleh	: 	Unggul Cahya Saputra  
---

# 

# 1\. Ringkasan Eksekutif

Satu Sehat Kobar adalah platform digital terpadu Dinas Kesehatan Kabupaten Kotawaringin Barat berbasis **AWCMS-Micro** dengan pola pengembangan **multi-plugin ecosystem**. Platform ini bukan pengganti platform **SATUSEHAT Kementerian Kesehatan**, tetapi menjadi platform internal/daerah untuk mengelola kebutuhan operasional, administrasi, pembinaan faskes, monitoring RME, monitoring SATUSEHAT, SPM Kesehatan, publikasi, dan pengambilan keputusan berbasis data.

PRD v1.4 ini menyempurnakan PRD v1.3 dengan pendekatan yang lebih ketat setara **Product Requirement Document formal / System Requirement Specification awal** untuk konteks pemerintahan dan SPBE. Penguatan utama meliputi:

1. Penambahan **user stories** dan **use cases** terstruktur.

2. Penambahan **diagram konteks sistem** dan **diagram arsitektur komponen**.

3. Penambahan detail **sumber daya tim**, **anggaran proyek**, dan **prioritas MoSCoW**.

4. Penambahan **glosarium formal**.

5. Penambahan kebijakan **retensi data dan manajemen arsip digital**.

6. Penyesuaian dengan prinsip PRD AWCMS-Micro:

   * downstream tetap kompatibel dengan EmDash;

   * perilaku produk diwujudkan melalui plugin dan template;

   * tidak membuat core fork;

   * API, route, handler, auth, migration, dan database mengikuti aturan AWCMS-Micro/EmDash;

   * deployment Cloudflare-ready dengan D1, R2, KV, dan secret handling;

   * localized UI dan dukungan i18n;

   * changelog/release notes per package/plugin;

   * AI sebagai lapisan asistif yang dapat diaudit dan tidak menggantikan validasi manusia.

Plugin awal yang menjadi isi operasional platform:

1. **awcms-micro-agenda-dinkes**

2. **awcms-micro-duty-travel**

3. **awcms-micro-satusehat-dashboard**

4. **awcms-micro-spm-health**

5. **awcms-micro-mmc-publication**

6. **awcms-micro-document-template**

7. **awcms-micro-document-archive**

# 2\. Tujuan PRD v1.4

## 2.1 Tujuan Umum

Menyediakan dokumen kebutuhan produk yang lengkap, terstruktur, dapat ditelusuri, dan siap digunakan sebagai dasar pengembangan Satu Sehat Kobar berbasis AWCMS-Micro, dimulai dari plugin Agenda Dinkes dan ST/SPPD sebagai fondasi operasional menuju integrasi RME, SATUSEHAT, SPM, pembinaan faskes, publikasi MMC, dan SPBE kesehatan daerah.

## 2.2 Tujuan Khusus

1. Menetapkan arah pengembangan Satu Sehat Kobar sebagai platform multi-plugin.

2. Menetapkan batasan scope MVP dan fase lanjutan.

3. Menetapkan kebutuhan fungsional dan non-fungsional.

4. Menyediakan user story dan use case untuk setiap kebutuhan utama.

5. Menyediakan acceptance criteria agar setiap fitur dapat diuji.

6. Menyediakan model data awal dan ERD konseptual.

7. Menyediakan diagram konteks sistem dan arsitektur komponen.

8. Menetapkan kebijakan keamanan, privasi, retensi, arsip, dan audit trail.

9. Menetapkan kebutuhan SDM dan anggaran awal.

10. Menetapkan prioritas pengembangan dengan MoSCoW.

11. Menjamin kesesuaian pengembangan dengan prinsip AWCMS-Micro.

12. Menyiapkan dasar formal untuk validasi Kadis, Sekretaris, Tim SIK, keuangan, umum/kepegawaian, faskes, Diskominfo/SPBE, dan stakeholder terkait.

# 3\. Perubahan dari PRD v1.3 ke PRD v1.4

| Area | PRD v1.3 | PRD v1.4 |
| ----- | ----- | ----- |
| Struktur kebutuhan | Fitur dan workflow | Ditambah user story, use case, acceptance criteria, dan traceability |
| Diagram | Workflow dan ERD dasar | Ditambah context diagram, component architecture, plugin interaction, deployment diagram, sequence diagram, RBAC/ABAC diagram |
| Scope | Agenda, ST/SPPD, SPM, MMC | Dipertajam dengan MoSCoW dan release boundary |
| AWCMS alignment | Sudah berbasis plugin | Diperkuat mengikuti PRD AWCMS-Micro: plugin/template boundary, no core fork, changelog, migrations, D1/R2/KV |
| Sumber daya | Belum rinci | Ditambah komposisi tim pengembangan MVP |
| Anggaran | Belum rinci | Ditambah struktur biaya proyek dan komponen pembiayaan |
| Retensi arsip | Umum | Ditambah kebijakan retensi aktif, inaktif, arsip final, pemusnahan/serah arsip sesuai JRA |
| Glosarium | Belum khusus | Ditambah daftar istilah formal |
| AI governance | Belum tegas | Ditambah aturan AI untuk draft laporan, draft MMC, redaksi data sensitif, dan audit |
| SPBE/SRS | PRD operasional | Diperkuat menjadi PRD/SRS-ready untuk pemerintahan |

# 4\. Glosarium dan Singkatan

| Istilah | Definisi |
| ----- | ----- |
| AWCMS-Micro | Platform pengembangan berbasis EmDash-compatible downstream yang menempatkan perilaku produk pada plugin, template, docs, workflow, dan release automation. |
| ABAC | Attribute-Based Access Control, pengendalian akses berbasis atribut seperti unit kerja, jabatan, lokasi, status pengajuan, dan kepemilikan data. |
| RBAC | Role-Based Access Control, pengendalian akses berbasis peran seperti Kadis, Sekretaris, Kabid, Keuangan, Operator Surat, Pegawai, Auditor. |
| Agenda Dinkes | Modul/plugin untuk mengelola agenda kegiatan Dinas Kesehatan dan faskes. |
| ST | Surat Tugas, dokumen penugasan resmi kepada pegawai/pelaksana. |
| SPPD | Surat Perintah Perjalanan Dinas atau dokumen perjalanan dinas sesuai ketentuan daerah. |
| SPM | Standar Pelayanan Minimal bidang kesehatan. |
| RME | Rekam Medis Elektronik. |
| SATUSEHAT | Platform integrasi data kesehatan nasional Kementerian Kesehatan. |
| Satu Sehat Kobar | Platform internal/daerah Dinas Kesehatan Kotawaringin Barat, bukan pengganti SATUSEHAT Kemenkes. |
| MMC | Media Monitoring Center / media publikasi kegiatan Dinkes. |
| TTE | Tanda Tangan Elektronik. |
| BSrE | Balai Sertifikasi Elektronik. |
| SRIKANDI | Sistem Informasi Kearsipan Dinamis Terintegrasi. |
| SIMPEG | Sistem Informasi Kepegawaian. |
| SIPD | Sistem Informasi Pemerintahan Daerah. |
| SPBE | Sistem Pemerintahan Berbasis Elektronik. |
| D1 | Cloudflare D1, database relasional serverless bila deployment menggunakan Cloudflare. |
| R2 | Cloudflare R2, object storage untuk dokumen, lampiran, bukti, dan arsip digital. |
| KV | Cloudflare KV, penyimpanan key-value untuk konfigurasi tertentu bila diperlukan. |
| PRD | Product Requirement Document. |
| SRS | System Requirement Specification. |
| MVP | Minimum Viable Product. |
| MoSCoW | Metode prioritas Must Have, Should Have, Could Have, Won’t Have. |
| Audit Trail | Catatan aktivitas sistem yang merekam siapa melakukan apa, kapan, dari mana, dan terhadap data apa. |
| Final Arsip | Status dokumen yang sudah final, ditandatangani, diverifikasi, dan dipindahkan ke pengelolaan arsip digital. |
| JRA | Jadwal Retensi Arsip. |
| KIP | Keterbukaan Informasi Publik. |
| PDP | Pelindungan Data Pribadi. |

# 5\. Dasar Regulasi, Standar, dan Rujukan Tata Kelola

## 5.1 Regulasi Nasional

1. Undang-Undang Nomor 14 Tahun 2008 tentang Keterbukaan Informasi Publik.

2. Undang-Undang Nomor 27 Tahun 2022 tentang Pelindungan Data Pribadi.

3. Undang-Undang Nomor 17 Tahun 2023 tentang Kesehatan.

4. Undang-Undang Nomor 43 Tahun 2009 tentang Kearsipan.

5. Peraturan Pemerintah Nomor 2 Tahun 2018 tentang Standar Pelayanan Minimal.

6. Peraturan Pemerintah Nomor 71 Tahun 2019 tentang Penyelenggaraan Sistem dan Transaksi Elektronik.

7. Peraturan Presiden Nomor 95 Tahun 2018 tentang Sistem Pemerintahan Berbasis Elektronik.

8. Peraturan Menteri Dalam Negeri Nomor 59 Tahun 2021 tentang Penerapan Standar Pelayanan Minimal.

9. Peraturan Menteri Dalam Negeri Nomor 1 Tahun 2023 tentang Tata Naskah Dinas di Lingkungan Pemerintah Daerah.

10. Peraturan Menteri Dalam Negeri Nomor 77 Tahun 2020 tentang Pedoman Teknis Pengelolaan Keuangan Daerah.

11. Peraturan Menteri Kesehatan Nomor 24 Tahun 2022 tentang Rekam Medis.

12. Peraturan Menteri Kesehatan Nomor 6 Tahun 2024 tentang Standar Teknis Pemenuhan Standar Pelayanan Minimal Kesehatan.

13. Regulasi sertifikat elektronik, PSrE, TTE, dan penyelenggaraan sertifikasi elektronik yang berlaku.

14. Regulasi SRIKANDI dan pengelolaan arsip dinamis yang berlaku.

15. Regulasi keamanan siber dan SPBE dari BSSN, Kominfo, ANRI, KemenPANRB, dan instansi terkait.

## 5.2 Regulasi Daerah dan Internal

1. Peraturan Bupati Kotawaringin Barat tentang perjalanan dinas dalam negeri yang berlaku.

2. Peraturan Bupati Kotawaringin Barat tentang standar harga satuan yang berlaku.

3. Ketentuan internal tata naskah Dinas Kesehatan.

4. Ketentuan internal penomoran surat dan arsip.

5. Ketentuan pengelolaan keuangan daerah oleh BKAD/BPKAD.

6. Ketentuan pengawasan oleh Inspektorat.

7. Ketentuan teknis Diskominfo/SPBE.

8. SK Tim Pengelola SIK/RME/Satu Sehat Kobar.

9. SOP administrasi ST/SPPD, bukti tugas, dan publikasi kegiatan.

## 5.3 Standar ISO/IEC dan Standar Pendukung

| Standar | Relevansi terhadap Satu Sehat Kobar |
| ----- | ----- |
| ISO/IEC 27001 | Sistem Manajemen Keamanan Informasi. |
| ISO/IEC 27002 | Kontrol keamanan informasi. |
| ISO/IEC 27005 | Manajemen risiko keamanan informasi. |
| ISO/IEC 27017 | Kontrol keamanan cloud. |
| ISO/IEC 27018 | Perlindungan data pribadi pada cloud publik. |
| ISO/IEC 27034 | Application security. |
| ISO/IEC 27701 | Privacy Information Management System. |
| ISO/IEC 29100 | Privacy framework. |
| ISO/IEC 20000 | IT Service Management. |
| ISO/IEC 22301 | Business Continuity Management. |
| ISO/IEC 15408 | Common Criteria/security assurance. |
| ISO/IEC 25010 | Software product quality model. |
| ISO 30301 | Management system for records. |
| ISO 15489 | Records management. |

# 6\. Visi Produk

Satu Sehat Kobar menjadi platform digital terpadu Dinas Kesehatan Kabupaten Kotawaringin Barat untuk mendukung pengelolaan agenda, ST/SPPD, bukti tugas, SPM, publikasi, pembinaan faskes, RME, SATUSEHAT, profil kesehatan, monitoring, evaluasi, arsip digital, dan pengambilan keputusan berbasis data dalam kerangka SPBE sektor kesehatan daerah.

# 7\. Prinsip Produk

1. **Satu platform, banyak plugin.**

2. **Tidak membuat aplikasi terpisah** untuk Agenda, ST/SPPD, SPM, MMC, RME, atau SATUSEHAT.

3. Semua fitur besar dikembangkan melalui **plugin AWCMS-Micro**.

4. Plugin wajib memiliki batas jelas: UI, API, handler, validation, migration, seed, docs, test, dan changelog.

5. Core AWCMS-Micro/EmDash tidak dimodifikasi untuk kebutuhan produk daerah kecuali melalui mekanisme resmi dan terkontrol.

6. Integrasi antar-plugin melalui **service contract/API**, bukan membaca tabel internal plugin lain secara langsung tanpa kontrak.

7. Setiap dokumen penting memiliki versi, metadata, hash, status, dan audit trail.

8. Setiap data pribadi, dokumen internal, dan arsip sensitif diatur dengan RBAC/ABAC.

9. AI hanya digunakan sebagai lapisan asistif untuk draft, ringkasan, redaksi, dan rekomendasi; keputusan final tetap oleh manusia.

10. Sistem harus mendukung audit, arsip, retensi, keamanan, dan interoperabilitas SPBE.

# 8\. Stakeholder

| Stakeholder | Peran |
| ----- | ----- |
| Kepala Dinas | Sponsor utama, pengambil keputusan, approval akhir, pemantauan strategis. |
| Sekretaris Dinas | Owner administrasi, tata naskah, koordinasi lintas bidang. |
| Kepala Bidang | Verifikator substansi program. |
| Kepala Subbag | Verifikator administrasi, umum, kepegawaian, atau keuangan sesuai fungsi. |
| Tim SIK | Product owner teknis, pengembang, integrator, admin sistem, keamanan, dashboard. |
| Subbag Keuangan | Validasi biaya, SPPD, sumber dana, pertanggungjawaban. |
| Subbag Umum/Kepegawaian | Tata naskah, nomor surat, data pegawai, arsip. |
| Operator Surat | Template, nomor, PDF, upload dokumen final. |
| Pegawai/Pelaksana | Pengajuan, pelaksanaan tugas, upload laporan dan bukti. |
| Atasan Langsung | Verifikasi pengajuan dan bukti bawahan. |
| Kepala Faskes | Approval akhir untuk pengajuan faskes. |
| Kepala TU Faskes | Administrasi, nomor, arsip, dan validasi faskes. |
| Reviewer MMC | Review draft publikasi dan keamanan informasi publik. |
| Diskominfo/SPBE | Interoperabilitas, keamanan, infrastruktur, domain/subdomain, standar SPBE. |
| BKAD/BPKAD | Validasi aspek penganggaran dan keuangan daerah. |
| Inspektorat | Pengawasan, audit, dan sampling bukti. |
| Bagian Hukum/Umum | Validasi tata naskah, regulasi, dan format dokumen. |
| ANRI/SRIKANDI terkait | Rujukan pengelolaan arsip dinamis dan integrasi arsip. |
| Masyarakat | Penerima manfaat tidak langsung dari peningkatan layanan dan publikasi informasi kesehatan. |

# 9\. Personas

## 9.1 Pegawai/Pemohon

Membuat pengajuan agenda, ST, SPPD, mengunggah dokumen pendukung, menerima notifikasi revisi, dan mengunggah bukti setelah tugas selesai.

## 9.2 Atasan Langsung

Memeriksa kelayakan pengajuan, memastikan pelaksana tidak bentrok jadwal, memberi catatan, menyetujui, mengembalikan, atau menolak.

## 9.3 Sekretaris Dinas

Memastikan tata naskah, administrasi, alur approval, dan konsistensi dokumen sebelum diterbitkan.

## 9.4 Keuangan

Memvalidasi sumber dana, kode rekening, standar biaya, dokumen pertanggungjawaban, dan bukti SPPD.

## 9.5 Operator Surat

Mengelola template, nomor surat, generate PDF, memeriksa format, mengunggah dokumen bertanda tangan, dan menetapkan status Final Arsip.

## 9.6 Kadis

Memberikan approval akhir, memantau dashboard strategis, melihat capaian SPM, beban tugas pegawai, bukti kegiatan, dan laporan tindak lanjut.

## 9.7 Tim SIK

Mengelola konfigurasi platform, plugin, user, role, API, database, backup, deployment, audit log, keamanan, dan pengembangan lanjutan.

## 9.8 Reviewer MMC

Meninjau draft publikasi kegiatan, menyaring data pribadi/sensitif, mengatur foto/caption, dan menyimpan link publikasi.

# 10\. Ruang Lingkup Produk

## 10.1 Scope MVP v1.4

1. Dashboard awal Satu Sehat Kobar.

2. Login, user, role, permission dasar.

3. Registry plugin awal.

4. Plugin Agenda Dinkes.

5. Plugin ST/SPPD.

6. Wizard input agenda.

7. Wizard input ST/SPPD.

8. Wizard approval.

9. Wizard operator dokumen.

10. Editor template ST/SPPD.

11. Generate PDF ST dan SPPD.

12. Download PDF siap tanda tangan manual/TTE eksternal.

13. Upload dokumen final bertanda tangan.

14. Upload laporan dan bukti tugas.

15. Verifikasi bukti.

16. Tagging SPM dan program prioritas.

17. Jurnal riwayat ST per pegawai.

18. Evaluasi efektivitas kunjungan.

19. Draft publikasi MMC.

20. Audit trail.

21. Export Excel/PDF.

22. API internal antar-plugin.

23. Retensi dan arsip digital dasar.

24. Dokumentasi admin dan pengguna.

## 10.2 Scope Lanjutan

1. Integrasi TTE/BSrE.

2. Integrasi SRIKANDI.

3. Integrasi SIMPEG.

4. Integrasi SIPD/keuangan.

5. Integrasi e-Kinerja.

6. Integrasi WhatsApp Gateway.

7. Plugin monitoring RME.

8. Plugin monitoring SATUSEHAT.

9. Plugin pembinaan faskes.

10. Plugin profil kesehatan.

11. Plugin geospasial kesehatan.

12. Plugin dashboard BI.

13. Plugin AI reporting.

14. Mobile responsive PWA.

15. API publik terbatas untuk informasi kegiatan yang boleh dipublikasikan.

## 10.3 Di Luar Scope MVP

1. TTE/BSrE penuh.

2. SRIKANDI penuh.

3. SIPD penuh.

4. SIMPEG penuh.

5. e-Kinerja penuh.

6. SATUSEHAT Kemenkes penuh.

7. Mobile app native Android/iOS.

8. OCR bukti otomatis.

9. AI fraud detection.

10. Pembayaran otomatis perjalanan dinas.

11. Penggantian SIMRS/SIMKES Khanza.

12. Penyimpanan data pasien klinis di plugin Agenda atau ST/SPPD.

# 11\. Prioritas Pengembangan MoSCoW

## 11.1 Must Have

| Kebutuhan | Alasan |
| ----- | ----- |
| Login dan role dasar | Sistem tidak boleh dipakai tanpa autentikasi. |
| Plugin registry | Satu Sehat Kobar harus mengikuti pola plugin AWCMS-Micro. |
| CRUD Agenda | Agenda menjadi sumber data kegiatan. |
| Wizard ST/SPPD | Inti proses administrasi tugas luar. |
| Approval sederhana | Dokumen tidak boleh terbit tanpa persetujuan. |
| Generate PDF ST | Output operasional paling penting. |
| Generate PDF SPPD dasar | Dibutuhkan untuk perjalanan berbiaya. |
| Upload dokumen final | Menyimpan dokumen resmi bertanda tangan. |
| Upload bukti tugas | Dasar akuntabilitas pelaksanaan. |
| Audit trail | Wajib untuk akuntabilitas pemerintahan. |
| Tagging SPM | Menghubungkan kegiatan dengan SPM Kesehatan. |
| Dashboard awal | Pimpinan membutuhkan ringkasan operasional. |
| RBAC dasar | Pembatasan akses minimal. |
| Backup harian | Perlindungan data operasional. |

## 11.2 Should Have

| Kebutuhan | Alasan |
| ----- | ----- |
| Approval berjenjang lengkap | Menyesuaikan alur Dinas/faskes. |
| Editor template lanjutan | Menyesuaikan tata naskah. |
| Jurnal pegawai detail | Monitoring beban dan riwayat tugas. |
| Efektivitas kunjungan | Evaluasi output kegiatan. |
| Draft MMC | Mendukung publikasi kegiatan. |
| Export Excel/PDF | Mendukung pelaporan. |
| Notifikasi | Mempercepat tindak lanjut. |
| QR validasi internal | Membantu verifikasi dokumen. |
| Retensi arsip awal | Menyiapkan tata kelola arsip digital. |

## 11.3 Could Have

| Kebutuhan | Alasan |
| ----- | ----- |
| AI draft laporan | Membantu produktivitas, bukan inti MVP. |
| AI draft MMC | Membantu redaksi, tetap perlu review manusia. |
| WhatsApp notification | Berguna, tetapi dapat menyusul. |
| Advanced analytics | Dapat dikembangkan setelah data cukup. |
| Geospasial lokasi tugas | Berguna untuk analisis wilayah. |
| Integrasi kalender eksternal | Opsional. |

## 11.4 Won’t Have pada MVP

| Kebutuhan | Alasan |
| :---- | :---- |
| TTE/BSrE penuh | Menunggu kesiapan integrasi resmi. |
| SRIKANDI penuh | Fase integrasi eksternal. |
| SATUSEHAT Kemenkes penuh | Fase monitoring/integrasi lanjutan. |
| Pembayaran otomatis SPPD | Butuh integrasi keuangan dan regulasi lebih kompleks. |
| Mobile app native | MVP cukup web responsive/PWA. |

# 12\. Diagram Konteks Sistem

flowchart LR  
    USER\[Pegawai / Faskes / Operator / Pimpinan\] \--\> SSK\[Satu Sehat Kobar\]

    SSK \--\> CORE\[Core AWCMS-Micro / EmDash Compatible Runtime\]  
    CORE \--\> PLUGINS\[Plugin Ecosystem\]

    PLUGINS \--\> AGENDA\[Plugin Agenda Dinkes\]  
    PLUGINS \--\> DUTY\[Plugin ST/SPPD\]  
    PLUGINS \--\> SPM\[Plugin SPM Health\]  
    PLUGINS \--\> MMC\[Plugin Publikasi MMC\]  
    PLUGINS \--\> ARCHIVE\[Plugin Arsip Dokumen\]  
    PLUGINS \--\> DASH\[Dashboard Satu Sehat Kobar\]  
    PLUGINS \--\> RME\[Plugin Monitoring RME\]  
    PLUGINS \--\> SATU\[Plugin Monitoring SATUSEHAT\]

    SSK \-. Fase 3 .-\> TTE\[TTE / BSrE\]  
    SSK \-. Fase 3 .-\> SRIKANDI\[SRIKANDI\]  
    SSK \-. Fase 3 .-\> SIMPEG\[SIMPEG / BKPSDM\]  
    SSK \-. Fase 3 .-\> SIPD\[SIPD / Keuangan Daerah\]  
    SSK \-. Fase 3 .-\> EKINERJA\[e-Kinerja\]  
    SSK \-. Fase 3 .-\> WA\[WhatsApp Gateway\]  
    SSK \-. Fase 2/3 .-\> KHANZA\[SIMRS/SIMKES Khanza\]  
    SSK \-. Fase 2/3 .-\> KEMENKES\[SATUSEHAT Kemenkes\]

    DASH \--\> KADIS\[Kadis / Sekretaris / Kabid\]  
    MMC \--\> PUBLIC\[Masyarakat / Kanal Publik\]

# 13\. Diagram Arsitektur Komponen

flowchart TB  
    subgraph ROOT\[Repository / Root Maintenance Layer\]  
        DOCS\[Docs / PRD / AGENTS / README\]  
        CHANGELOG\[Root Snapshot Changelog\]  
        CI\[Validation / Build / Test / Release Automation\]  
    end

    subgraph WORKSPACE\[awcmsmicro-dev / Runtime Workspace\]  
        CORE\[AWCMS-Micro Core\<br/\>EmDash-compatible\]  
        AUTH\[Auth / Session / Permission\]  
        ADMIN\[Admin UI\]  
        API\[API Routes / Handlers\]  
        MIG\[Migrations\]  
    end

    subgraph PLUGIN\_LAYER\[Plugin Layer\]  
        AGENDA\[awcms-micro-agenda-dinkes\]  
        DUTY\[awcms-micro-duty-travel\]  
        SPM\[awcms-micro-spm-health\]  
        MMC\[awcms-micro-mmc-publication\]  
        DOCPLUG\[awcms-micro-document-template\]  
        ARCH\[awcms-micro-document-archive\]  
        DASH\[awcms-micro-satusehat-dashboard\]  
    end

    subgraph STORAGE\[Data & Storage\]  
        DB\[(D1 / SQL Database)\]  
        R2\[(R2 Object Storage)\]  
        KV\[(KV Settings / Edge State)\]  
        LOG\[(Audit Logs)\]  
    end

    subgraph TEMPLATE\[Template Layer\]  
        ASTRO\[Astro Public Template\]  
        ADMINUX\[React/Kumo Admin Components\]  
    end

    ROOT \--\> WORKSPACE  
    WORKSPACE \--\> PLUGIN\_LAYER  
    PLUGIN\_LAYER \--\> API  
    API \--\> DB  
    API \--\> R2  
    API \--\> KV  
    API \--\> LOG  
    ADMIN \--\> ADMINUX  
    TEMPLATE \--\> WORKSPACE  
    CI \--\> WORKSPACE  
    PLUGIN\_LAYER \--\> CHANGELOG

# 14\. Diagram Interaksi Antar-Plugin

flowchart LR  
    AGENDA\[Agenda Dinkes\] \--\>|service contract: event snapshot| DUTY\[ST/SPPD\]  
    DUTY \--\>|classification data| SPM\[SPM Health\]  
    DUTY \--\>|verified report \+ sanitized media| MMC\[Publikasi MMC\]  
    DUTY \--\>|final document metadata| ARCH\[Arsip Dokumen\]  
    AGENDA \--\>|agenda stats| DASH\[Dashboard\]  
    DUTY \--\>|request status \+ evidence status| DASH  
    SPM \--\>|SPM aggregates| DASH  
    MMC \--\>|publication status| DASH  
    ARCH \--\>|archive status| DASH

# 15\. User Stories Utama

## 15.1 Plugin Agenda Dinkes

| ID | User Story | Acceptance Criteria |
| ----- | ----- | ----- |
| US-AG-001 | Sebagai Pegawai/Pemohon, saya ingin membuat agenda kegiatan agar kegiatan dapat terdokumentasi sejak tahap perencanaan. | Agenda dapat dibuat, disimpan sebagai draft, diberi waktu/lokasi, peserta, lampiran, status, dan audit trail. |
| US-AG-002 | Sebagai Admin Agenda, saya ingin mengklasifikasikan agenda berdasarkan SPM/program agar kegiatan dapat dipantau kontribusinya terhadap prioritas kesehatan. | Agenda memiliki kategori SPM/program; perubahan klasifikasi tercatat; kategori tampil di dashboard. |
| US-AG-003 | Sebagai Pegawai, saya ingin membuat ST dari agenda agar tidak perlu menginput ulang data kegiatan. | ST dapat dibuat dari agenda; sistem mengambil snapshot judul, waktu, lokasi, lampiran, dan tag SPM. |
| US-AG-004 | Sebagai Sekretaris, saya ingin melihat agenda yang membutuhkan ST agar administrasi kegiatan dapat diproses tepat waktu. | Dashboard menampilkan agenda “Need ST”; filter tersedia; link ke pengajuan ST tersedia. |
| US-AG-005 | Sebagai Reviewer MMC, saya ingin melihat agenda yang berpotensi publikasi agar kegiatan publik dapat disiapkan menjadi berita. | Agenda memiliki flag potensi publikasi; hanya agenda publik/layak yang masuk daftar MMC. |
| US-AG-006 | Sebagai Pimpinan, saya ingin melihat kalender agenda Dinkes dan faskes agar koordinasi lintas unit lebih mudah. | Kalender tersedia dengan filter unit, faskes, SPM, program, status, dan tanggal. |

## 15.2 Plugin ST/SPPD

| ID | User Story | Acceptance Criteria |
| ----- | ----- | ----- |
| US-ST-001 | Sebagai Pegawai, saya ingin mengajukan ST melalui wizard agar proses pengajuan lebih tertib dan lengkap. | Wizard memiliki step wajib; validasi per step; autosave; preview ringkasan; submit menghasilkan nomor tracking. |
| US-ST-002 | Sebagai Pegawai, saya ingin memilih dasar ST dari agenda, undangan, disposisi, surat masuk, atau SPM agar dasar penugasan jelas. | Field dasar ST wajib; lampiran sesuai jenis dasar; data dasar tampil di PDF. |
| US-ST-003 | Sebagai Atasan, saya ingin memverifikasi pengajuan agar hanya tugas yang relevan dan tidak bentrok jadwal yang diproses. | Atasan dapat approve, return, reject, hold; catatan wajib untuk return/reject; audit trail tercatat. |
| US-ST-004 | Sebagai Keuangan, saya ingin memvalidasi sumber dana dan biaya SPPD agar perjalanan dinas sesuai aturan keuangan daerah. | Sumber dana, kode rekening, komponen biaya, estimasi biaya, dan catatan validasi tersedia. |
| US-ST-005 | Sebagai Operator Surat, saya ingin menghasilkan PDF ST/SPPD siap tanda tangan agar dokumen dapat diproses meskipun TTE belum terintegrasi. | Sistem menghasilkan PDF draft/final; area tanda tangan tersedia; QR internal dan metadata dokumen tersedia. |
| US-ST-006 | Sebagai Pelaksana, saya ingin mengunggah laporan dan bukti tugas agar tugas dapat diverifikasi selesai. | Laporan dan bukti dapat diunggah; checklist bukti tampil; status berubah menjadi Evidence Submitted. |
| US-ST-007 | Sebagai Verifikator, saya ingin menilai kelengkapan bukti dan efektivitas kunjungan agar hasil tugas dapat dievaluasi. | Skor efektivitas dapat diisi; bukti dapat diterima/dikembalikan; tindak lanjut dapat ditandai. |
| US-ST-008 | Sebagai Pegawai, saya ingin melihat jurnal ST saya agar riwayat tugas luar terdokumentasi. | Jurnal per pegawai menampilkan nomor ST, tanggal, lokasi, rekan, output, bukti, SPM, status, dan link dokumen. |

## 15.3 Plugin MMC

| ID | User Story | Acceptance Criteria |
| ----- | ----- | ----- |
| US-MMC-001 | Sebagai Reviewer MMC, saya ingin sistem membuat draft publikasi dari laporan tugas agar publikasi kegiatan lebih cepat. | Draft MMC dibuat dari laporan terverifikasi; data sensitif disaring; status draft tercatat. |
| US-MMC-002 | Sebagai Reviewer MMC, saya ingin meninjau foto dan caption agar publikasi tidak melanggar privasi. | Foto dapat dipilih; caption dapat diedit; data pasien/rincian biaya tidak boleh masuk publikasi. |
| US-MMC-003 | Sebagai Pimpinan, saya ingin melihat daftar draft publikasi agar kegiatan Dinkes yang layak publik diketahui masyarakat. | Dashboard MMC menampilkan draft, review, siap kirim, terbit, tidak dipublikasikan. |

## 15.4 Dashboard Pimpinan

| ID | User Story | Acceptance Criteria |
| ----- | ----- | ----- |
| US-DB-001 | Sebagai Kadis, saya ingin melihat ringkasan agenda, ST, SPPD, bukti, SPM, dan MMC agar keputusan cepat berbasis data. | Dashboard menampilkan kartu indikator, grafik tren, daftar pending, urgent, dan filter waktu/unit. |
| US-DB-002 | Sebagai Sekretaris, saya ingin melihat bottleneck approval agar proses administrasi bisa dipercepat. | Dashboard menampilkan daftar pengajuan menunggu approval per tahap dan durasi tunggu. |
| US-DB-003 | Sebagai Kabid, saya ingin melihat kegiatan berdasarkan program/SPM agar pembinaan program lebih terukur. | Dashboard dapat difilter per bidang, program, SPM, faskes, dan wilayah. |

# 16\. Use Cases Formal

## UC-001 Membuat Agenda

| Elemen | Deskripsi |
| ----- | ----- |
| Aktor Utama | Pegawai/Admin Agenda |
| Tujuan | Membuat agenda kegiatan Dinas/faskes. |
| Prasyarat | User login dan memiliki permission membuat agenda. |
| Alur Utama | Buka plugin Agenda → klik Buat Agenda → isi identitas → isi waktu/lokasi → pilih SPM/program → unggah lampiran → review → simpan/ajukan. |
| Alur Alternatif | Agenda disimpan draft; agenda dikembalikan; agenda dibatalkan; agenda dijadwalkan ulang. |
| Output | Agenda tersimpan dengan status Draft/Proposed/Confirmed. |
| Acceptance Criteria | Semua field wajib tervalidasi; audit trail tercatat; agenda tampil di kalender. |

## UC-002 Membuat ST dari Agenda

| Elemen | Deskripsi |
| ----- | ----- |
| Aktor Utama | Pegawai/Pemohon |
| Tujuan | Membuat pengajuan ST berdasarkan agenda yang sudah ada. |
| Prasyarat | Agenda minimal status Proposed/Confirmed dan user punya akses. |
| Alur Utama | Buka agenda → klik Buat ST → sistem membuat snapshot agenda → user melengkapi pelaksana, lokasi, waktu, output, biaya jika ada → preview → submit. |
| Alur Alternatif | Agenda berubah setelah ST dibuat; sistem memberi warning; user memilih revisi atau lanjut sesuai izin. |
| Output | Pengajuan ST/SPPD status Submitted. |
| Acceptance Criteria | ST memiliki agenda\_id, snapshot agenda, klasifikasi SPM/program, dan nomor tracking. |

## UC-003 Approval ST/SPPD

| Elemen | Deskripsi |
| ----- | ----- |
| Aktor Utama | Atasan, Kabid, Sekretaris, Keuangan, Kadis/Kepala Faskes |
| Tujuan | Memverifikasi dan menyetujui pengajuan. |
| Prasyarat | Pengajuan status Submitted. |
| Alur Utama | Approver membuka daftar pending → review ringkasan → cek dokumen → cek SPM/program → cek biaya jika ada → approve/return/reject/hold. |
| Output | Status pengajuan berubah sesuai keputusan. |
| Acceptance Criteria | Semua keputusan tercatat; catatan wajib untuk return/reject/override; notifikasi tahap berikutnya dibuat. |

## UC-004 Generate PDF ST/SPPD

| Elemen | Deskripsi |
| :---: | :---: |
| Aktor Utama | Operator Surat |
| Tujuan | Menghasilkan PDF ST/SPPD sesuai tata naskah. |
| Prasyarat | Pengajuan Final Approved. |
| Alur Utama | Operator memilih template → isi nomor surat → pilih pejabat penandatangan → preview → generate PDF → download → unggah final signed. |
| Output | Dokumen PDF status Siap Tanda Tangan / Final Arsip. |
| Acceptance Criteria | PDF memiliki nomor, metadata, hash, QR internal, versi, dan audit trail. |

## UC-005 Upload dan Verifikasi Bukti

| Elemen | Deskripsi |
| ----- | ----- |
| Aktor Utama | Pelaksana dan Verifikator |
| Tujuan | Menutup siklus tugas dengan laporan dan bukti. |
| Prasyarat | ST status Document Issued/In Progress. |
| Alur Utama | Pelaksana upload laporan → upload bukti → isi tindak lanjut → submit → verifikator review → terima/kembalikan/escalate. |
| Output | Status Evidence Verified/Returned/Completed. |
| Acceptance Criteria | Tugas tidak dapat Completed tanpa bukti terverifikasi. |

## UC-006 Membuat Draft MMC

| Elemen | Deskripsi |
| ----- | ----- |
| Aktor Utama | Reviewer MMC |
| Tujuan | Membuat draft publikasi dari laporan kegiatan. |
| Prasyarat | Bukti/laporan tugas sudah diverifikasi. |
| Alur Utama | Sistem menandai potensi publikasi → reviewer membuka draft → sistem menyalin ringkasan non-sensitif → reviewer edit → pilih foto → review redaksi → simpan link publikasi. |
| Output | Draft MMC status Draft/Review/Siap Kirim/Dipublikasikan. |
| Acceptance Criteria | Data pasien, rincian biaya, dan data pribadi tidak relevan tidak masuk publikasi. |

# 17\. Workflow Umum Modul Awal

flowchart TD  
    A\[Agenda / Kebutuhan Kegiatan\] \--\> B\[Plugin Agenda Dinkes\]  
    B \--\> C{Perlu ST?}  
    C \--\>|Tidak| B1\[Agenda Berjalan / Arsip Agenda\]  
    C \--\>|Ya| D\[Buat Pengajuan ST/SPPD\]  
    D \--\> E\[Wizard Input ST/SPPD\]  
    E \--\> F\[Klasifikasi SPM / Program Prioritas\]  
    F \--\> G\[Pilih Pelaksana, Lokasi, Waktu, Output\]  
    G \--\> H{Berbiaya?}  
    H \--\>|Ya| I\[Input SPPD dan Anggaran\]  
    H \--\>|Tidak| J\[Upload Dokumen Pendukung\]  
    I \--\> J  
    J \--\> K\[Preview ST/SPPD\]  
    K \--\> L\[Submit Pengajuan\]  
    L \--\> M\[Approval Berjenjang\]  
    M \--\>|Return| E  
    M \--\>|Reject| R\[Pengajuan Ditolak\]  
    M \--\>|Approve| N\[Operator Dokumen\]  
    N \--\> O\[Generate PDF Siap Tanda Tangan/TTE Eksternal\]  
    O \--\> P\[Download PDF\]  
    P \--\> Q\[Tanda Tangan Manual / TTE Eksternal\]  
    Q \--\> S\[Upload Dokumen Final\]  
    S \--\> T\[Pelaksanaan Tugas\]  
    T \--\> U\[Upload Laporan dan Bukti\]  
    U \--\> V\[Verifikasi Bukti\]  
    V \--\>|Kurang| U  
    V \--\>|Lengkap| W\[Jurnal Pegawai \+ Efektivitas\]  
    W \--\> X{Layak MMC?}  
    X \--\>|Ya| Y\[Draft Publikasi MMC\]  
    X \--\>|Tidak| Z\[Final Arsip\]  
    Y \--\> Z  
    Z \--\> AA\[Dashboard Satu Sehat Kobar\]

# 18\. State Machine Status ST/SPPD

stateDiagram-v2  
    \[\*\] \--\> Draft  
    Draft \--\> Submitted  
    Submitted \--\> Returned  
    Returned \--\> Draft  
    Submitted \--\> Rejected  
    Submitted \--\> SupervisorVerified  
    SupervisorVerified \--\> TechnicalVerified  
    TechnicalVerified \--\> SecretaryVerified  
    SecretaryVerified \--\> FinanceVerified  
    SecretaryVerified \--\> FinalApproved  
    FinanceVerified \--\> FinalApproved  
    FinalApproved \--\> DocumentIssued  
    DocumentIssued \--\> InProgress  
    InProgress \--\> EvidenceSubmitted  
    EvidenceSubmitted \--\> EvidenceReturned  
    EvidenceReturned \--\> EvidenceSubmitted  
    EvidenceSubmitted \--\> EvidenceVerified  
    EvidenceVerified \--\> Completed  
    Completed \--\> Archived  
    FinalApproved \--\> Cancelled  
    DocumentIssued \--\> Cancelled  
    Archived \--\> \[\*\]  
    Rejected \--\> \[\*\]  
    Cancelled \--\> \[\*\]

# 19\. Functional Requirements

## 19.1 Platform Satu Sehat Kobar

| ID | Requirement | Priority |
| ----- | ----- | ----- |
| FR-PL-001 | Sistem menyediakan dashboard utama Satu Sehat Kobar. | Must |
| FR-PL-002 | Sistem menyediakan plugin registry untuk mengaktifkan/menonaktifkan plugin. | Must |
| FR-PL-003 | Sistem menyediakan role dan permission lintas plugin. | Must |
| FR-PL-004 | Sistem menyediakan audit trail lintas plugin. | Must |
| FR-PL-005 | Sistem menyediakan konfigurasi umum platform. | Should |
| FR-PL-006 | Sistem menyediakan localization Bahasa Indonesia dan Inggris untuk UI aktif. | Should |
| FR-PL-007 | Sistem menyediakan package changelog/release notes per plugin. | Should |
| FR-PL-008 | Sistem menyediakan endpoint dashboard agregat melalui service contract. | Must |

## 19.2 Plugin Agenda

| ID | Requirement | Priority |
| ----- | ----- | ----- |
| FR-AG-001 | Sistem dapat membuat, membaca, mengubah, membatalkan, dan mengarsipkan agenda. | Must |
| FR-AG-002 | Sistem menyediakan kalender agenda. | Should |
| FR-AG-003 | Sistem mendukung agenda Dinas dan agenda faskes. | Must |
| FR-AG-004 | Sistem mendukung agenda internal, terbatas, dan publik. | Must |
| FR-AG-005 | Sistem mendukung tagging SPM dan program prioritas. | Must |
| FR-AG-006 | Sistem mendukung upload lampiran agenda. | Must |
| FR-AG-007 | Sistem mendukung peserta internal dan eksternal. | Should |
| FR-AG-008 | Sistem dapat menghubungkan agenda dengan ST/SPPD. | Must |
| FR-AG-009 | Sistem dapat menandai potensi publikasi MMC. | Should |
| FR-AG-010 | Sistem menyediakan API read-only untuk plugin lain. | Must |

## 19.3 Plugin ST/SPPD

| ID | Requirement | Priority |
| ----- | ----- | ----- |
| FR-ST-001 | Sistem menyediakan wizard pengajuan ST. | Must |
| FR-ST-002 | Sistem menyediakan wizard pengajuan SPPD untuk pengajuan berbiaya. | Must |
| FR-ST-003 | Sistem menyediakan workflow approval. | Must |
| FR-ST-004 | Sistem menyediakan editor template ST/SPPD. | Must |
| FR-ST-005 | Sistem dapat generate PDF ST/SPPD. | Must |
| FR-ST-006 | Sistem dapat download PDF siap tanda tangan manual/TTE eksternal. | Must |
| FR-ST-007 | Sistem dapat upload dokumen final bertanda tangan. | Must |
| FR-ST-008 | Sistem menyediakan upload bukti dan laporan. | Must |
| FR-ST-009 | Sistem menyediakan verifikasi bukti. | Must |
| FR-ST-010 | Sistem menyediakan jurnal riwayat ST per pegawai. | Must |
| FR-ST-011 | Sistem menyediakan skor efektivitas kunjungan. | Should |
| FR-ST-012 | Sistem menyediakan draft MMC dari laporan tugas. | Should |
| FR-ST-013 | Sistem menyediakan export Excel/PDF. | Should |
| FR-ST-014 | Sistem menyediakan QR validasi internal dan hash dokumen. | Should |

# 

# 20\. Non-Functional Requirements

## 20.1 Keamanan

1. Authentication aman.

2. Password hashing kuat.

3. Session management aman.

4. RBAC dan ABAC.

5. CSRF protection.

6. XSS protection.

7. SQL injection protection.

8. IDOR protection.

9. Validasi upload file.

10. Rate limiting untuk endpoint penting.

11. Secure headers.

12. Audit trail untuk aksi penting.

13. Enkripsi data sensitif.

14. Backup terenkripsi.

15. Least privilege access.

16. Tidak menyimpan secrets pada repository.

17. Access log untuk dokumen sensitif.

18. Separation of duties untuk approval dan operator dokumen.

## 20.2 Privasi dan PDP

1. Data pribadi pegawai hanya ditampilkan sesuai kewenangan.

2. NIP/NIK tidak ditampilkan di publikasi kecuali diperlukan dan sah.

3. Data pasien dilarang masuk modul publikasi MMC.

4. Bukti kegiatan yang memuat data sensitif wajib diklasifikasi.

5. Draft publikasi harus melalui redaksi data pribadi.

6. AI tidak boleh memproses data sensitif tanpa kebijakan eksplisit.

7. Log AI, bila digunakan, harus diminimalkan dan memiliki retensi.

8. Hak akses dokumen harus tercatat.

9. Ekspor data dibatasi berdasarkan role.

10. Penghapusan/retensi mengikuti JRA dan kebijakan arsip.

## 20.3 Performa

1. Dashboard pilot tampil kurang dari 3 detik.

2. Generate PDF kurang dari 10 detik untuk dokumen standar.

3. Export 10.000 baris kurang dari 30 detik pada data pilot.

4. Semua daftar data wajib menggunakan pagination.

5. Query dashboard menggunakan agregasi/index.

6. Upload file dibatasi ukuran dan tipe.

7. Endpoint API penting memiliki timeout dan error handling.

8. Sistem tetap responsif pada jaringan faskes yang tidak stabil.

## 20.4 Ketersediaan dan Keberlanjutan

1. Uptime pilot minimal 99% pada jam kerja.

2. Backup database harian.

3. Backup dokumen/object storage harian atau incremental.

4. RPO awal maksimal 24 jam.

5. RTO awal 4–8 jam.

6. Restore test minimal bulanan pada masa pilot.

7. Monitoring error aktif.

8. Prosedur mode manual tersedia saat sistem gangguan.

## 20.5 Maintainability

1. Setiap plugin memiliki README.

2. Setiap plugin memiliki changelog.

3. Setiap migration bersifat forward-only.

4. Setiap API memiliki dokumentasi.

5. Setiap perubahan besar dibuat dalam issue/task terpisah.

6. Perubahan dilakukan atomic dan reviewable.

7. Plugin tidak boleh mengubah core AWCMS-Micro secara langsung.

8. Struktur folder mengikuti standar AWCMS-Micro.

# 21\. Data Model dan ERD Konseptual

## 21.1 Entitas Utama

1. users

2. roles

3. permissions

4. organization\_units

5. health\_facilities

6. employees

7. satusehat\_modules

8. satusehat\_plugin\_registry

9. agenda\_events

10. agenda\_event\_participants

11. agenda\_event\_attachments

12. agenda\_event\_spm\_links

13. duty\_requests

14. duty\_request\_participants

15. duty\_request\_approvals

16. duty\_request\_budget\_lines

17. duty\_documents

18. duty\_document\_versions

19. duty\_evidences

20. duty\_reports

21. duty\_person\_journals

22. duty\_visit\_effectiveness\_scores

23. duty\_publication\_drafts

24. document\_archives

25. audit\_logs

## 21.2 ERD Konseptual

erDiagram  
    users ||--o{ employees : maps\_to  
    roles ||--o{ user\_roles : assigned  
    users ||--o{ user\_roles : has  
    organization\_units ||--o{ employees : contains  
    health\_facilities ||--o{ employees : employs

    satusehat\_modules ||--o{ satusehat\_plugin\_registry : registered\_as

    agenda\_events ||--o{ agenda\_event\_participants : has  
    agenda\_events ||--o{ agenda\_event\_attachments : has  
    agenda\_events ||--o{ agenda\_event\_spm\_links : classified\_as  
    agenda\_events ||--o{ duty\_agenda\_links : linked\_to

    duty\_requests ||--o{ duty\_request\_participants : has  
    duty\_requests ||--o{ duty\_request\_approvals : approved\_by  
    duty\_requests ||--o{ duty\_request\_budget\_lines : funded\_by  
    duty\_requests ||--o{ duty\_documents : generates  
    duty\_documents ||--o{ duty\_document\_versions : versioned\_as  
    duty\_requests ||--o{ duty\_evidences : requires  
    duty\_requests ||--o{ duty\_reports : has  
    duty\_requests ||--o{ duty\_person\_journals : recorded\_in  
    employees ||--o{ duty\_person\_journals : owns  
    duty\_requests ||--o{ duty\_visit\_effectiveness\_scores : evaluated\_by  
    duty\_requests ||--o{ duty\_publication\_drafts : may\_generate  
    duty\_documents ||--o{ document\_archives : archived\_as

    users ||--o{ audit\_logs : performs  
    agenda\_events ||--o{ audit\_logs : audited  
    duty\_requests ||--o{ audit\_logs : audited  
    duty\_documents ||--o{ audit\_logs : audited

    users {  
        text id  
        text email  
        text name  
        text status  
    }

    employees {  
        text id  
        text user\_id  
        text nip  
        text name  
        text position  
        text organization\_unit\_id  
        text health\_facility\_id  
    }

    agenda\_events {  
        text id  
        text title  
        text status  
        datetime start\_at  
        datetime end\_at  
        text visibility  
        text created\_by  
    }

    duty\_requests {  
        text id  
        text tracking\_number  
        text agenda\_snapshot\_id  
        text request\_type  
        text spm\_category  
        text status  
        text requested\_by  
    }

    duty\_documents {  
        text id  
        text duty\_request\_id  
        text document\_type  
        text document\_number  
        text status  
        text hash  
    }

    document\_archives {  
        text id  
        text document\_id  
        text archive\_status  
        text retention\_class  
        date active\_until  
        date inactive\_until  
    }

    audit\_logs {  
        text id  
        text actor\_id  
        text action  
        text entity\_type  
        text entity\_id  
        datetime created\_at  
    }

---

# 22\. API Internal Konseptual

## 22.1 Platform API

GET    /api/satusehat/modules  
GET    /api/satusehat/plugins  
PATCH  /api/satusehat/plugins/:plugin\_key/status  
GET    /api/satusehat/dashboard  
GET    /api/satusehat/audit-logs

## 22.2 Agenda API

GET    /api/agenda/events  
POST   /api/agenda/events  
GET    /api/agenda/events/:id  
PATCH  /api/agenda/events/:id  
POST   /api/agenda/events/:id/submit  
POST   /api/agenda/events/:id/confirm  
POST   /api/agenda/events/:id/cancel  
POST   /api/agenda/events/:id/reschedule  
GET    /api/agenda/events/:id/st-links  
GET    /api/agenda/events/:id/attachments

## 22.3 Duty Travel API

GET    /api/duty-requests  
POST   /api/duty-requests  
GET    /api/duty-requests/:id  
PATCH  /api/duty-requests/:id  
POST   /api/duty-requests/:id/submit  
POST   /api/duty-requests/:id/approve  
POST   /api/duty-requests/:id/return  
POST   /api/duty-requests/:id/reject  
POST   /api/duty-requests/:id/cancel  
POST   /api/duty-requests/from-agenda/:agenda\_id

## 22.4 Document API

POST   /api/duty-requests/:id/generate-st  
POST   /api/duty-requests/:id/generate-sppd  
GET    /api/duty-documents/:id/download  
POST   /api/duty-documents/:id/upload-signed  
GET    /api/duty-documents/:id/verify  
POST   /api/duty-documents/:id/archive

## 22.5 Evidence API

POST   /api/duty-requests/:id/evidences  
GET    /api/duty-requests/:id/evidences  
POST   /api/duty-requests/:id/evidences/submit  
POST   /api/duty-evidences/:id/verify  
POST   /api/duty-evidences/:id/return

## 22.6 MMC API

POST   /api/mmc/drafts/from-duty/:duty\_request\_id  
GET    /api/mmc/drafts  
GET    /api/mmc/drafts/:id  
PATCH  /api/mmc/drafts/:id  
POST   /api/mmc/drafts/:id/review  
POST   /api/mmc/drafts/:id/mark-published

# 23\. RBAC/ABAC

## 23.1 Role

| Role | Hak Akses Utama |
| ----- | ----- |
| Super Admin | Semua konfigurasi platform. |
| Admin Satu Sehat Kobar | Konfigurasi platform, plugin, dashboard, integrasi. |
| Admin Tim SIK | User, role, audit, teknis, backup, deployment. |
| Admin OPD | Master OPD, template, nomor, dashboard OPD. |
| Admin Faskes | Master faskes, pegawai faskes, arsip faskes. |
| Pegawai/Pemohon | Buat agenda/ST, revisi, upload bukti miliknya. |
| Pelaksana | Melihat ST miliknya dan upload laporan/bukti. |
| Atasan Langsung | Verifikasi pengajuan dan bukti bawahan. |
| Kabid | Verifikasi teknis bidang. |
| Sekretaris | Verifikasi administrasi Dinas. |
| Kadis | Approval akhir dan dashboard strategis. |
| Kepala Faskes | Approval akhir faskes. |
| Kepala TU Faskes | Administrasi, nomor, arsip faskes. |
| Keuangan | Validasi biaya, SPPD, pertanggungjawaban. |
| Operator Surat | Template, nomor, generate PDF, upload final. |
| Reviewer MMC | Review draft publikasi. |
| Auditor | View-only audit trail, laporan, sampling bukti. |
| Viewer Pimpinan | Dashboard dan laporan strategis. |

## 23.2 Diagram RBAC/ABAC

flowchart TD  
    USER\[User Login\] \--\> AUTH\[Authentication\]  
    AUTH \--\> RBAC{Role Check}  
    RBAC \--\>|Role allowed| ABAC{Attribute Check}  
    RBAC \--\>|Role denied| DENY\[Access Denied\]

    ABAC \--\> UNIT\[Unit/Faskes Ownership\]  
    ABAC \--\> STATUS\[Status Workflow\]  
    ABAC \--\> DOC\[Document Classification\]  
    ABAC \--\> REL\[Relationship to Request\]

    UNIT \--\> DECISION{Allowed?}  
    STATUS \--\> DECISION  
    DOC \--\> DECISION  
    REL \--\> DECISION

    DECISION \--\>|Yes| ACCESS\[Grant Access\]  
    DECISION \--\>|No| DENY

    ACCESS \--\> AUDIT\[Write Audit Log\]  
    DENY \--\> AUDIT

# 24\. Retensi Data dan Manajemen Arsip Digital

## 24.1 Prinsip Retensi

1. Retensi mengikuti ketentuan kearsipan nasional, JRA yang berlaku, dan kebijakan internal pemerintah daerah.

2. Data operasional tidak boleh dihapus sembarangan.

3. Dokumen final bertanda tangan diperlakukan sebagai arsip digital.

4. Dokumen yang belum final dapat memiliki masa simpan lebih pendek, tetapi tetap harus mengikuti audit trail.

5. Penghapusan data harus melalui prosedur role khusus, approval, dan audit.

6. Integrasi dengan SRIKANDI disiapkan pada fase lanjutan.

## 24.2 Kategori Data dan Retensi Awal

| Jenis Data | Status Aktif | Status Inaktif | Tindakan Akhir |
| ----- | ----- | ----- | ----- |
| Agenda kegiatan biasa | 2 tahun | 3 tahun | Musnah/arsip sesuai nilai guna |
| Agenda strategis/SPM/RME/SATUSEHAT | 5 tahun | 5 tahun | Dinilai kembali/permanen bila bernilai kebijakan |
| Draft pengajuan ST yang tidak disubmit | 6 bulan | \- | Dihapus otomatis setelah notifikasi |
| Pengajuan ST ditolak | 2 tahun | 3 tahun | Musnah sesuai JRA |
| ST final | 5 tahun | 5 tahun | Dinilai kembali/arsip |
| SPPD dan dokumen keuangan | Mengikuti JRA keuangan daerah | Mengikuti JRA keuangan daerah | Sesuai JRA keuangan |
| Bukti tugas non-keuangan | 5 tahun | 5 tahun | Dinilai kembali |
| Bukti SPPD/pertanggungjawaban | Mengikuti JRA keuangan | Mengikuti JRA keuangan | Sesuai JRA keuangan |
| Jurnal pegawai | Selama pegawai aktif \+ 5 tahun | 5 tahun | Dinilai kembali |
| Draft MMC tidak dipublikasikan | 1 tahun | 1 tahun | Musnah |
| Publikasi MMC | Selama masih relevan | Permanen/arsip publikasi | Permanen bila bernilai sejarah |
| Audit trail keamanan | Minimal 2 tahun | 3 tahun | Dinilai kembali |
| Log akses dokumen sensitif | Minimal 2 tahun | 3 tahun | Dinilai kembali |
| Backup | Harian 30 hari, bulanan 12 bulan | Tahunan sesuai kebijakan | Rotasi aman |

## 24.3 Status Arsip Digital

1. Draft.

2. Dalam Proses.

3. Siap Tanda Tangan.

4. Final Ditandatangani.

5. Final Arsip.

6. Arsip Aktif.

7. Arsip Inaktif.

8. Dipindahkan ke Sistem Arsip.

9. Dinilai Kembali.

10. Dimusnahkan.

11. Permanen.

## 24.4 Prosedur Arsip Digital

flowchart TD  
    A\[Dokumen Final Ditandatangani\] \--\> B\[Upload Final Signed PDF\]  
    B \--\> C\[Verifikasi Metadata dan Hash\]  
    C \--\> D\[Set Status Final Arsip\]  
    D \--\> E\[Masuk Arsip Aktif\]  
    E \--\> F{Masa Aktif Selesai?}  
    F \--\>|Tidak| E  
    F \--\>|Ya| G\[Pindah Arsip Inaktif\]  
    G \--\> H{Integrasi SRIKANDI Tersedia?}  
    H \--\>|Ya| I\[Kirim Metadata/Dokumen ke SRIKANDI\]  
    H \--\>|Tidak| J\[Simpan di Repository Arsip Internal\]  
    I \--\> K\[Retensi sesuai JRA\]  
    J \--\> K  
    K \--\> L{Tindakan Akhir}  
    L \--\> M\[Musnah\]  
    L \--\> N\[Dinilai Kembali\]  
    L \--\> O\[Permanen\]

## 24.5 Metadata Arsip Minimal

1. ID dokumen.

2. Nomor dokumen.

3. Jenis dokumen.

4. Tanggal dokumen.

5. Unit pencipta arsip.

6. Pejabat penandatangan.

7. Pemilik proses.

8. Klasifikasi keamanan.

9. Klasifikasi akses.

10. Hash dokumen.

11. Versi dokumen.

12. Status dokumen.

13. Lokasi penyimpanan.

14. Masa aktif.

15. Masa inaktif.

16. Tindakan akhir.

17. Riwayat akses.

18. Riwayat perubahan.

19. Relasi agenda/ST/SPPD.

20. Relasi SPM/program.

# 25\. AI Governance

## 25.1 Fungsi AI yang Diizinkan

1. Membantu membuat draft laporan tugas.

2. Membantu membuat ringkasan hasil kegiatan.

3. Membantu membuat draft publikasi MMC.

4. Membantu redaksi data sensitif.

5. Membantu klasifikasi awal SPM/program.

6. Membantu rekomendasi tindak lanjut.

7. Membantu pencarian arsip internal sesuai hak akses.

## 25.2 Fungsi AI yang Tidak Diizinkan pada MVP

1. Menyetujui pengajuan otomatis.

2. Menolak pengajuan otomatis.

3. Mengubah status final dokumen.

4. Menghapus arsip.

5. Mengirim publikasi tanpa review manusia.

6. Mengirim data pasien ke layanan AI eksternal.

7. Menggunakan production secrets dalam prompt.

8. Menggantikan verifikasi keuangan.

9. Menggantikan pertimbangan pejabat berwenang.

## 25.3 Acceptance Criteria AI

1. UI menampilkan label “dibantu AI” bila output dihasilkan AI.

2. User dapat mengedit, menerima, atau menolak output AI.

3. Output AI tidak otomatis menjadi final.

4. Prompt dan output penting dapat diaudit.

5. Data sensitif diminimalkan sebelum diproses.

6. Fitur AI dapat dinonaktifkan tanpa merusak alur utama.

7. Fallback non-AI tersedia.

8. Biaya, latency, dan kualitas output dievaluasi.

# 26\. Sumber Daya Tim Pengembangan

## 26.1 Komposisi Tim MVP Minimal

| Peran | Jumlah | Tanggung Jawab |
| ----- | ----- | ----- |
| Product Owner / Project Sponsor | 1 | Validasi kebutuhan, prioritas, keputusan scope. |
| Project Manager / Scrum Master | 1 | Rencana kerja, timeline, koordinasi stakeholder, risiko. |
| System Analyst / Business Analyst | 1 | Proses bisnis, user story, SRS, acceptance criteria. |
| Solution Architect | 1 | Arsitektur plugin, integrasi, database, security baseline. |
| Full-stack Developer | 2 | Implementasi plugin Agenda, ST/SPPD, dashboard, API, UI. |
| UI/UX Designer | 1 | Wizard, dashboard, form, mobile responsive, usability. |
| QA / Tester | 1 | Test plan, functional test, security test dasar, UAT. |
| DevOps / Cloud Engineer | 1 | Deployment, backup, restore, monitoring, CI/CD. |
| Security & Privacy Reviewer | 1 paruh waktu | Review RBAC/ABAC, PDP, upload, audit, threat model. |
| Admin Dokumentasi/SOP | 1 paruh waktu | Manual pengguna, SOP, notulen, materi pelatihan. |
| Perwakilan Sekretariat | 1–2 | Validasi tata naskah dan alur administrasi. |
| Perwakilan Keuangan | 1 | Validasi SPPD, biaya, sumber dana, bukti keuangan. |
| Perwakilan Faskes Pilot | 2–5 | UAT dan feedback operasional. |

## 26.2 RACI Ringkas

| Aktivitas | Kadis | Sekretaris | Tim SIK | Keuangan | Operator Surat | Faskes Pilot |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| Validasi PRD | A | R | R | C | C | C |
| Desain workflow | C | A/R | R | C | C | C |
| Desain arsitektur | I | C | A/R | I | I | I |
| Implementasi plugin | I | C | A/R | C | C | I |
| Validasi tata naskah | C | A/R | C | I | R | C |
| Validasi biaya | I | C | C | A/R | I | C |
| UAT | A | R | R | R | R | R |
| Go-live pilot | A | R | R | C | C | C |
| Evaluasi pilot | A | R | R | R | C | R |

Keterangan:  
A \= Accountable, R \= Responsible, C \= Consulted, I \= Informed.

# 27\. Struktur Anggaran/Biaya Proyek

## 27.1 Prinsip Anggaran

1. Anggaran mengikuti ketentuan pengelolaan keuangan daerah.

2. Komponen biaya harus dapat dipertanggungjawabkan.

3. Prioritas awal adalah MVP yang memberikan manfaat operasional cepat.

4. Penggunaan layanan cloud harus memiliki estimasi biaya operasional bulanan.

5. Pengadaan jasa, perangkat, atau langganan mengikuti regulasi pengadaan yang berlaku.

6. Komponen open-source tetap memerlukan biaya implementasi, keamanan, pemeliharaan, dan operasional.

## 27.2 Komponen Anggaran

| Komponen | Keterangan | Prioritas |
| ----- | ----- | ----- |
| Analisis kebutuhan dan PRD/SRS | Workshop, dokumen, validasi stakeholder | Must |
| Desain UI/UX | Wireframe, prototype, desain wizard/dashboard | Must |
| Pengembangan plugin Agenda | CRUD, kalender, API, audit | Must |
| Pengembangan plugin ST/SPPD | Wizard, approval, PDF, bukti, jurnal | Must |
| Pengembangan dashboard | Dashboard pimpinan dan operasional | Must |
| Template dokumen | ST, SPPD, laporan, bukti | Must |
| Infrastruktur hosting/cloud | Server/Cloudflare/D1/R2/KV/domain/subdomain | Must |
| Backup dan monitoring | Backup database, object storage, restore test | Must |
| Security hardening | RBAC/ABAC, upload validation, headers, audit | Must |
| Testing dan UAT | Test case, UAT faskes, perbaikan bug | Must |
| Pelatihan pengguna | Materi, manual, video, pendampingan | Should |
| Integrasi TTE/BSrE | Fase lanjutan | Should |
| Integrasi SRIKANDI | Fase lanjutan | Should |
| Integrasi SIMPEG/SIPD | Fase lanjutan | Could |
| AI assistant | Draft laporan/MMC/redaksi | Could |
| Maintenance tahunan | Support, bugfix, update dependency | Must |

## 27.3 Estimasi Kategori Biaya

| Kategori | Deskripsi |
| ----- | ----- |
| Biaya SDM internal | Waktu Tim SIK, sekretariat, keuangan, operator, faskes pilot. |
| Biaya jasa pengembangan | Bila menggunakan konsultan/vendor/pengembang tambahan. |
| Biaya infrastruktur | Hosting, database, storage, backup, CDN, domain/subdomain. |
| Biaya keamanan | Audit keamanan, vulnerability scanning, hardening, pelatihan keamanan. |
| Biaya pelatihan | Sosialisasi, modul, video, pendampingan pilot. |
| Biaya pemeliharaan | Update plugin, bugfix, monitoring, backup, dokumentasi. |
| Biaya integrasi | TTE/BSrE, SRIKANDI, SIMPEG, SIPD, SATUSEHAT, WhatsApp Gateway. |

# 28\. Roadmap Implementasi

gantt  
    title Roadmap MVP Satu Sehat Kobar v1.4  
    dateFormat  YYYY-MM-DD  
    section Persiapan  
    Validasi PRD dan scope MVP              :a1, 2026-06-15, 5d  
    Setup repo, environment, plugin registry:a2, after a1, 5d  
    section MVP Core  
    Dashboard awal dan RBAC dasar           :b1, after a2, 7d  
    Plugin Agenda Dinkes                    :b2, after a2, 10d  
    Plugin ST/SPPD wizard                   :b3, after b1, 14d  
    Approval dan operator dokumen           :b4, after b3, 10d  
    PDF ST/SPPD dan template editor         :b5, after b3, 10d  
    section Bukti dan Dashboard  
    Upload bukti dan verifikasi             :c1, after b4, 7d  
    Jurnal pegawai dan efektivitas          :c2, after c1, 7d  
    Dashboard SPM/MMC                       :c3, after c1, 7d  
    section Hardening  
    Audit trail, backup, keamanan           :d1, after c2, 7d  
    UAT dan pilot faskes                    :d2, after d1, 10d  
    Evaluasi dan perbaikan                  :d3, after d2, 7d

## 28.1 Fase 1 — Fondasi Operasional

Output:

1. Platform dapat diakses.

2. Plugin Agenda aktif.

3. Plugin ST/SPPD aktif.

4. ST dapat dibuat dari agenda.

5. PDF ST/SPPD dapat dibuat dan diunduh.

6. Dokumen final dapat diunggah.

7. Bukti tugas dapat diunggah.

8. Dashboard awal tersedia.

## 28.2 Fase 2 — Penguatan Program dan Faskes

Output:

1. Approval berjenjang lengkap.

2. Faskes pilot aktif.

3. Dashboard SPM lebih lengkap.

4. Jurnal pegawai detail.

5. Monitoring bukti terlambat.

6. Tindak lanjut hasil kunjungan.

## 28.3 Fase 3 — Integrasi Eksternal

Output:

1. Integrasi TTE/BSrE.

2. Integrasi SRIKANDI.

3. Integrasi SIMPEG.

4. Integrasi SIPD/Keuangan.

5. Integrasi e-Kinerja.

6. Integrasi WhatsApp Gateway.

7. Integrasi monitoring SATUSEHAT/RME.

## 28.4 Fase 4 — Intelligence dan Analitik

Output:

1. BI dashboard.

2. Analitik SPM.

3. Analitik pembinaan faskes.

4. AI draft laporan dan publikasi dengan governance.

5. Geospasial kesehatan.

6. Data warehouse kesehatan daerah.

# 29\. Deployment Architecture

flowchart TB  
    DEV\[Developer Workstation\] \--\> GITHUB\[GitHub Repository\]  
    GITHUB \--\> CI\[CI/CD Validation\]  
    CI \--\> BUILD\[Build & Test\]  
    BUILD \--\> DEPLOY\[Deploy\]

    DEPLOY \--\> CF\[Cloudflare Workers / Pages\]  
    CF \--\> D1\[(Cloudflare D1 / SQL)\]  
    CF \--\> R2\[(Cloudflare R2 Object Storage)\]  
    CF \--\> KV\[(Cloudflare KV)\]  
    CF \--\> SECRETS\[Environment Secrets\]

    CF \--\> ADMIN\[Admin UI\]  
    CF \--\> PUBLIC\[Public Site / MMC\]  
    CF \--\> API\[API Endpoints\]

    ADMIN \--\> USERS\[Internal Users\]  
    PUBLIC \--\> SOCIETY\[Masyarakat\]  
    API \--\> INTEGRATION\[Future External Integrations\]

# 30\. Testing dan Quality Assurance

## 30.1 Functional Test

1. Login dan logout.

2. Role access.

3. Plugin registry.

4. CRUD agenda.

5. Agenda menjadi dasar ST.

6. Wizard ST.

7. Wizard SPPD.

8. Approval.

9. Return/revision/reject.

10. Generate PDF.

11. Upload final signed PDF.

12. Upload bukti.

13. Verifikasi bukti.

14. Jurnal pegawai.

15. Draft MMC.

16. Export laporan.

17. Dashboard.

18. Arsip dokumen.

## 30.2 Security Test

1. RBAC bypass test.

2. ABAC ownership test.

3. IDOR test.

4. XSS test.

5. CSRF test.

6. SQL injection test.

7. Upload malicious file test.

8. Session hijacking test dasar.

9. Rate limit test.

10. Audit log completeness test.

11. Sensitive document access test.

12. Secret leakage scan.

## 30.3 Integration Test

1. Agenda API ke Duty API.

2. Duty API ke Dashboard API.

3. Duty API ke Document API.

4. Duty API ke Evidence API.

5. Duty API ke MMC API.

6. Document API ke Object Storage.

7. Dashboard ke aggregate endpoints.

8. Export PDF/Excel.

9. Backup dan restore.

10. QR/hash validation.

## 30.4 UAT

Kelompok UAT:

1. Sekretariat.

2. Keuangan.

3. Bidang teknis.

4. Tim SIK.

5. Operator Surat.

6. Faskes pilot.

7. Pimpinan/viewer.

8. Reviewer MMC.

# 31\. Acceptance Criteria Global

## 31.1 Platform

1. Satu Sehat Kobar dapat diakses melalui domain/subdomain resmi.

2. User dapat login sesuai role.

3. Plugin awal terdaftar pada plugin registry.

4. Dashboard utama tampil.

5. Audit trail berjalan.

6. Tidak ada secret pada repository.

7. Struktur plugin tidak mengubah core AWCMS-Micro.

8. Changelog plugin tersedia.

## 31.2 Agenda

1. Agenda dapat dibuat, diedit, dibatalkan, dijadwalkan ulang, dan diarsipkan.

2. Agenda dapat diberi tag SPM/program.

3. Agenda dapat diberi lampiran.

4. Agenda dapat menjadi dasar ST.

5. Agenda menampilkan ST terkait.

6. Agenda internal tidak otomatis dipublikasikan.

7. Perubahan agenda setelah ST final memunculkan warning.

## 31.3 ST/SPPD

1. Pengajuan dapat dibuat melalui wizard.

2. ST dapat dibuat dari agenda.

3. Pengajuan wajib memiliki dasar ST.

4. Pengajuan wajib memiliki klasifikasi SPM/program.

5. Approval dapat approve, return, reject, hold.

6. Catatan wajib untuk return/reject/override.

7. PDF ST dapat dihasilkan.

8. PDF SPPD dapat dihasilkan untuk pengajuan berbiaya.

9. Dokumen final signed dapat diunggah.

10. Semua versi dokumen tercatat.

11. Tugas tidak completed tanpa bukti terverifikasi.

## 31.4 Bukti dan Laporan

1. Pelaksana dapat upload laporan.

2. Pelaksana dapat upload bukti.

3. Bukti memiliki klasifikasi.

4. Bukti dapat diverifikasi.

5. Bukti dapat dikembalikan.

6. Tindak lanjut dapat dicatat.

7. Efektivitas dapat diberi skor.

## 31.5 Arsip

1. Dokumen final dapat ditetapkan sebagai Final Arsip.

2. Metadata arsip tersimpan.

3. Hash dokumen tersimpan.

4. Retensi awal dapat dihitung.

5. Akses arsip tercatat.

6. Dokumen arsip tidak dapat diubah tanpa mekanisme revisi/addendum.

# 32\. KPI Keberhasilan

| KPI | Target Awal |
| ----- | ----- |
| Platform dapat digunakan | Minggu 1 MVP |
| Plugin Agenda aktif | Minggu 1 MVP |
| Plugin ST/SPPD aktif | Minggu 1 MVP |
| ST dibuat melalui sistem | 80% dalam 3 bulan pilot |
| Agenda terkonfirmasi yang dapat menjadi dasar ST | 100% |
| Waktu penerbitan ST tanpa biaya | Turun 50% |
| Waktu penerbitan ST \+ SPPD | Turun 40% |
| Tugas dengan bukti lengkap | Minimal 90% |
| ST terkait SPM/program tercatat | 100% |
| Pegawai pelaksana memiliki jurnal ST | 100% |
| Draft MMC dari kegiatan layak publikasi | Minimal 50% kegiatan layak |
| Unit/faskes aktif pilot | Minimal 5 unit awal |
| Kepuasan pengguna | Minimal 80% puas/cukup puas |
| Dokumen final memiliki metadata dan hash | 100% |
| Audit trail aksi penting | 100% |

# 33\. Risiko dan Mitigasi

| Risiko | Dampak | Mitigasi |
| ----- | ----- | ----- |
| Scope terlalu luas | Implementasi lambat | Gunakan MoSCoW dan MVP. |
| Plugin tidak konsisten | Sulit dirawat | Standar plugin, changelog, migration, docs. |
| Format tata naskah berubah | PDF tidak sesuai | Editor template dan versioning template. |
| TTE belum siap | Dokumen belum full digital | PDF siap tanda tangan manual/TTE eksternal. |
| Approval berbeda antar faskes | Workflow rumit | Approval chain konfigurabel. |
| Regulasi biaya berubah | SPPD tidak sesuai | Master biaya versioned. |
| Data sensitif masuk MMC | Risiko privasi | Review manusia dan redaksi data. |
| Bukti tidak lengkap | Akuntabilitas lemah | Checklist bukti dan status Evidence Returned. |
| Akses dokumen salah | Kebocoran data | RBAC/ABAC, audit akses, klasifikasi dokumen. |
| Internet faskes tidak stabil | Penggunaan terganggu | UI ringan, autosave, retry upload. |
| Dependensi cloud berubah | Gangguan operasional | Backup, export, dokumentasi restore. |
| AI menghasilkan output salah | Kesalahan publikasi/laporan | Human review wajib dan fallback non-AI. |

# 34\. Contoh Implementasi Praktis

## 34.1 Pembinaan RME dan SATUSEHAT

1. Admin membuat agenda “Pembinaan RME dan SATUSEHAT Puskesmas”.

2. Agenda diberi tag program prioritas RME/SATUSEHAT.

3. Pegawai membuat ST dari agenda.

4. Sistem menarik snapshot agenda.

5. Approval berjalan.

6. Operator menghasilkan PDF ST/SPPD.

7. Pelaksana upload laporan, foto, dan tindak lanjut.

8. Dashboard RME/SATUSEHAT diperbarui.

## 34.2 Pembinaan SPM Hipertensi

1. Agenda dibuat untuk pembinaan capaian hipertensi.

2. Tag SPM: pelayanan kesehatan penderita hipertensi.

3. ST dibuat dari agenda.

4. Bukti hasil pembinaan diunggah.

5. Tindak lanjut capaian hipertensi dicatat.

6. Dashboard SPM menampilkan kontribusi kegiatan.

## 34.3 Kegiatan Publikasi MMC

1. Agenda kegiatan promosi kesehatan dibuat.

2. Potensi publikasi MMC dipilih.

3. ST diterbitkan.

4. Laporan dan foto diunggah.

5. Sistem membuat draft MMC.

6. Reviewer menghapus data sensitif.

7. Link publikasi disimpan setelah tayang.

## 34.4 Tugas Faskes

1. Pegawai puskesmas membuat pengajuan ST.

2. Kepala TU memeriksa administrasi.

3. Kepala Faskes menyetujui.

4. ST PDF diterbitkan.

5. Pegawai upload laporan dan bukti.

6. Data masuk dashboard faskes dan Dinkes.

## 34.5 Perjalanan Dinas Berbiaya

1. Agenda pelatihan luar daerah dibuat.

2. ST \+ SPPD diajukan.

3. Keuangan memvalidasi sumber dana dan biaya.

4. Operator membuat PDF ST/SPPD.

5. Dokumen ditandatangani.

6. Bukti perjalanan dan pertanggungjawaban diunggah.

7. Keuangan/verifikator memeriksa bukti.

# 35\. Perbandingan Pelajaran Implementasi

| Kasus | Pelajaran untuk Satu Sehat Kobar |
| ----- | ----- |
| SRIKANDI | Arsip digital harus disiapkan sejak awal dengan metadata, status, retensi, dan klasifikasi. |
| SATUSEHAT Kemenkes | Integrasi harus berbasis standar, service contract, dan data governance. |
| SPBE Pemerintah Daerah | Sistem harus mendukung interoperabilitas, keamanan, audit, dan efisiensi layanan. |
| Sistem e-Office/Tata Naskah | PDF, nomor surat, pejabat penandatangan, dan lifecycle dokumen harus jelas. |
| SIMPEG/e-Kinerja | Data pegawai, aktivitas, dan output harus bisa ditelusuri tanpa duplikasi input berlebihan. |

# 36\. Keputusan yang Perlu Diminta kepada Kadis

1. Menyetujui Satu Sehat Kobar sebagai platform digital terpadu Dinkes Kobar berbasis AWCMS-Micro.

2. Menyetujui Agenda Dinkes dan ST/SPPD sebagai plugin awal.

3. Menyetujui bahwa ST/SPPD tidak dibuat sebagai aplikasi terpisah.

4. Menyetujui pola pengembangan semua fitur melalui plugin.

5. Menyetujui penggunaan PDF siap tanda tangan manual/TTE eksternal sebelum integrasi TTE penuh.

6. Menyetujui pencatatan SPM pada agenda dan ST.

7. Menyetujui jurnal ST per pegawai.

8. Menyetujui draft publikasi MMC dari laporan tugas dengan review manusia.

9. Menyetujui kebijakan retensi dan arsip digital awal.

10. Menyetujui unit/faskes pilot.

11. Menyetujui Tim SIK sebagai pengelola teknis platform.

12. Menyetujui Sekretariat sebagai owner administrasi ST/SPPD.

13. Menyetujui Keuangan sebagai owner validasi biaya/SPPD.

14. Menyetujui roadmap MVP dan fase integrasi lanjutan.

# 37\. Dokumen Pendukung yang Harus Disiapkan

1. Telaahan staf kepada Kadis.

2. SK Tim Pengelola Satu Sehat Kobar.

3. SOP input agenda.

4. SOP pengajuan ST.

5. SOP pengajuan SPPD.

6. SOP approval Dinas.

7. SOP approval faskes.

8. SOP operator dokumen.

9. SOP generate/download PDF.

10. SOP tanda tangan manual/TTE eksternal.

11. SOP upload dokumen final.

12. SOP upload bukti.

13. SOP verifikasi bukti.

14. SOP draft publikasi MMC.

15. SOP arsip digital dan retensi.

16. SOP backup dan restore.

17. SOP keamanan akses.

18. Manual pengguna.

19. Manual admin.

20. Manual operator surat.

21. Manual reviewer MMC.

22. Format ST.

23. Format SPPD.

24. Format laporan hasil tugas.

25. Format checklist bukti.

26. Form evaluasi pilot.

27. Video tutorial.

28. Dokumen arsitektur teknis.

29. Dokumen API internal.

30. Dokumen data dictionary.

# 38\. Data Dictionary Awal

| Field | Entitas | Deskripsi |
| ----- | ----- | ----- |
| agenda\_id | agenda\_events | ID unik agenda. |
| agenda\_snapshot\_id | duty\_requests | Snapshot agenda saat ST dibuat. |
| tracking\_number | duty\_requests | Nomor tracking pengajuan. |
| request\_type | duty\_requests | Jenis pengajuan: ST tanpa biaya, ST dengan SPPD, urgent. |
| spm\_category | duty\_requests | Kategori SPM: langsung, pendukung, non-SPM prioritas, tidak terkait. |
| status | duty\_requests | Status lifecycle pengajuan. |
| document\_hash | duty\_documents | Hash dokumen PDF untuk validasi integritas. |
| retention\_class | document\_archives | Kelas retensi arsip. |
| active\_until | document\_archives | Batas masa arsip aktif. |
| inactive\_until | document\_archives | Batas masa arsip inaktif. |
| visibility | agenda\_events / mmc\_drafts | Klasifikasi akses/publikasi. |
| evidence\_status | duty\_evidences | Status bukti tugas. |
| effectiveness\_score | duty\_visit\_effectiveness\_scores | Skor efektivitas kunjungan. |

# 39\. Backlog Plugin Lanjutan

1. awcms-micro-rme-monitoring

2. awcms-micro-satusehat-integration

3. awcms-micro-health-facility

4. awcms-micro-spm-health

5. awcms-micro-health-profile

6. awcms-micro-faskes-coaching

7. awcms-micro-geospatial-health

8. awcms-micro-mmc-publication

9. awcms-micro-document-archive

10. awcms-micro-esign-integration

11. awcms-micro-srikandi-integration

12. awcms-micro-simpeg-integration

13. awcms-micro-sipd-integration

14. awcms-micro-ekinerja-support

15. awcms-micro-whatsapp-notification

16. awcms-micro-health-bi-dashboard

17. awcms-micro-ai-reporting

18. awcms-micro-public-service-survey

19. awcms-micro-it-asset-health

20. awcms-micro-knowledge-base

# 40\. Kesimpulan

PRD v1.4 menetapkan Satu Sehat Kobar sebagai platform digital terpadu berbasis AWCMS-Micro dengan Agenda Dinkes dan ST/SPPD sebagai plugin awal. Dokumen ini memperkuat PRD v1.3 menjadi lebih formal, terukur, dan siap digunakan sebagai dasar validasi, pengembangan MVP, UAT, pilot, serta ekspansi menuju integrasi RME, SATUSEHAT, SPM, SRIKANDI, TTE/BSrE, SIMPEG, SIPD, e-Kinerja, dan SPBE kesehatan daerah.

Nilai utama PRD v1.4:

1. Memiliki struktur kebutuhan yang dapat dilacak.

2. Memiliki user story dan use case.

3. Memiliki acceptance criteria.

4. Memiliki diagram konteks, arsitektur, workflow, ERD, deployment, dan RBAC/ABAC.

5. Memiliki prioritas MoSCoW untuk mencegah scope creep.

6. Memiliki kebijakan retensi dan arsip digital.

7. Memiliki struktur tim dan anggaran.

8. Memiliki dasar keamanan, privasi, audit, dan AI governance.

9. Selaras dengan prinsip AWCMS-Micro.

10. Siap menjadi dokumen acuan pengembangan MVP dan validasi pimpinan.

Rekomendasi tindak lanjut:

1. Validasi PRD v1.4 bersama Kadis, Sekretaris, Tim SIK, Keuangan, Umum/Kepegawaian, dan faskes pilot.

2. Tetapkan scope MVP berdasarkan MoSCoW.

3. Susun SK Tim Pengelola Satu Sehat Kobar.

4. Buat GitHub issues berdasarkan user stories dan functional requirements.

5. Siapkan struktur plugin sesuai AWCMS-Micro.

6. Susun SOP pilot.

7. Mulai implementasi atomic: platform → registry → agenda → ST/SPPD → PDF → bukti → dashboard → arsip.

# 

# **BAGIAN TAMBAHAN AKHIR PRD v1.4**

## **Fondasi Master Data, Wilayah, Faskes, Organisasi, Pegawai, Penandatangan, Penomoran, SPM, dan Koordinat Lokasi**

---

## **1\. Latar Belakang Penambahan**

PRD v1.4 Satu Sehat Kobar telah menetapkan arah utama pengembangan sebagai platform berbasis AWCMS-Micro dengan alur utama:

Agenda

→ Surat Tugas/SPPD

→ Approval

→ PDF

→ Upload Dokumen Final

→ Bukti Tugas

→ Verifikasi

→ Jurnal Pegawai

→ Dashboard

→ Arsip

Namun, untuk memastikan sistem dapat berjalan secara lebih valid, terstruktur, dan siap dikembangkan ke fase berikutnya, diperlukan penambahan fondasi master data.

Fondasi master data ini penting karena Agenda, ST/SPPD, dashboard, monitoring SPM, monitoring faskes, pembinaan RME/SATUSEHAT, dan arsip tidak dapat berjalan optimal apabila data wilayah, faskes, unit organisasi, pegawai, pejabat penandatangan, penomoran, dan SPM masih berupa input bebas.

Oleh karena itu, PRD v1.4 perlu ditambahkan dengan bagian khusus mengenai **Master Data dan Lokasi**.

## **2\. Tujuan Penambahan**

Penambahan ini bertujuan untuk:

1. Menjamin wilayah tujuan kegiatan dan ST/SPPD mengacu pada wilayah resmi.  
2. Menjamin wilayah lokal seperti RT, RW, dusun, lingkungan, dan lokus program dapat dikelola secara tertib.  
3. Menjamin faskes tujuan ST/SPPD dapat dipilih dari master faskes.  
4. Menjamin koordinat lokasi Agenda dan ST/SPPD dapat disimpan.  
5. Menjamin unit organisasi Dinkes, bidang, UPTD, dan faskes dapat menjadi dasar RBAC/ABAC.  
6. Menjamin pegawai pelaksana, approver, dan pejabat penandatangan memiliki referensi master.  
7. Menjamin nomor ST/SPPD dikelola melalui mekanisme penomoran yang terkendali.  
8. Menjamin Agenda dan ST/SPPD dapat dikaitkan dengan master SPM/program.  
9. Menyiapkan dashboard wilayah, dashboard faskes, dashboard SPM, dan dashboard pembinaan.  
10. Menyiapkan fondasi integrasi lanjutan dengan SIMPEG, SATUSEHAT, Khanza, SRIKANDI, SIPD, dan sistem lain.

## **3\. Prinsip Desain Master Data**

Master data dalam Satu Sehat Kobar mengikuti prinsip:

1. **Master data sebagai referensi utama.**  
   Data wilayah, faskes, unit, pegawai, pejabat, penomoran, dan SPM tidak boleh hanya berupa input bebas.  
2. **Plugin-first.**  
   Master data dikembangkan sebagai plugin atau service modular dalam ekosistem AWCMS-Micro.  
3. **Tidak mengubah core secara sembarangan.**  
   Logika khusus daerah ditempatkan pada plugin, bukan pada core AWCMS-Micro.  
4. **Data resmi dan data lokal dipisahkan.**  
   Wilayah resmi mengikuti referensi resmi, sedangkan wilayah lokal menginduk pada wilayah resmi.  
5. **Snapshot untuk dokumen final.**  
   Data pegawai, pejabat, unit, faskes, dan lokasi yang digunakan dalam ST/SPPD harus dapat disimpan sebagai snapshot agar dokumen historis tidak berubah ketika master data diperbarui.  
6. **Aman dan berbasis kewenangan.**  
   Data pegawai, kontak PIC, dokumen, dan data finance hanya dapat dilihat oleh role yang berwenang.  
7. **Dashboard-ready.**  
   Master data harus dapat digunakan untuk rekap dashboard per wilayah, faskes, unit, pegawai, dan SPM.  
8. **Future integration-ready.**  
   Master data disiapkan agar dapat digunakan untuk integrasi fase lanjutan.

## 

## **4\. Plugin Master Data yang Ditambahkan**

Tambahkan plugin fondasi berikut dalam ruang lingkup PRD:

awcms-micro-official-region

awcms-micro-local-region

awcms-micro-health-facility

awcms-micro-organization-unit

awcms-micro-personnel-master

awcms-micro-signatory-numbering

awcms-micro-spm-master

awcms-micro-calendar-master

awcms-micro-transport-master

awcms-micro-approval-template

## **5\. Klasifikasi Prioritas Plugin**

| Plugin | Prioritas | Keterangan |
| ----- | ----- | ----- |
| `awcms-micro-official-region` | Must Have | Master wilayah resmi. |
| `awcms-micro-health-facility` | Must Have | Master faskes tujuan ST/SPPD. |
| `awcms-micro-organization-unit` | Must Have | Struktur Dinkes, bidang, UPTD, dan faskes. |
| `awcms-micro-personnel-master` | Must Have | Master pegawai lokal sebelum integrasi SIMPEG. |
| `awcms-micro-signatory-numbering` | Must Have | Pejabat penandatangan dan penomoran ST/SPPD. |
| `awcms-micro-spm-master` | Must Have | Master SPM, indikator, program, dan kategori kegiatan. |
| `awcms-micro-local-region` | Should/Must Have | Wilayah lokal seperti RT/RW/dusun/lokus program. |
| `awcms-micro-calendar-master` | Should Have | Hari libur/cuti bersama dan validasi tanggal. |
| `awcms-micro-transport-master` | Could/Should Have | Referensi alat angkut SPPD. |
| `awcms-micro-approval-template` | Should Have | Template alur approval per unit/faskes/jenis ST. |

## **6\. Plugin Wilayah Resmi**

### **6.1 Tujuan**

Plugin wilayah resmi digunakan untuk mengelola referensi wilayah administrasi pemerintahan, meliputi:

1. Provinsi.  
2. Kabupaten/kota.  
3. Kecamatan.  
4. Desa/kelurahan.

### **6.2 Fungsi**

Plugin ini digunakan untuk:

1. Referensi wilayah Agenda.  
2. Referensi wilayah tujuan ST/SPPD.  
3. Referensi wilayah faskes.  
4. Referensi wilayah lokal.  
5. Rekap dashboard per wilayah.  
6. Analisis cakupan kegiatan.  
7. Persiapan integrasi geospasial.

### **6.3 Aturan**

1. Data wilayah resmi tidak boleh diedit bebas oleh user biasa.  
2. Perubahan data wilayah resmi dilakukan melalui import/sinkronisasi oleh admin berwenang.  
3. Setiap import wilayah harus memiliki batch log.  
4. Wilayah resmi harus memiliki kode, nama, level, parent, status, dan sumber data.  
5. Wilayah lokal wajib menginduk ke wilayah resmi level desa/kelurahan.

## 

## **7\. Plugin Wilayah Lokal**

### **7.1 Tujuan**

Plugin wilayah lokal digunakan untuk mengelola wilayah yang lebih rinci dari desa/kelurahan.

Contoh:

1. RT.  
2. RW.  
3. Dusun.  
4. Lingkungan.  
5. Blok.  
6. Komplek.  
7. Kawasan.  
8. Lokus program.  
9. Wilayah binaan.  
10. Custom area.

### **7.2 Aturan**

1. Wilayah lokal wajib menginduk ke desa/kelurahan resmi.  
2. Wilayah lokal dapat memiliki parent lokal.  
3. Wilayah lokal dapat memiliki koordinat.  
4. Wilayah lokal dapat dipilih pada Agenda dan ST/SPPD.  
5. Wilayah lokal dapat dikaitkan dengan faskes binaan.  
6. Perubahan wilayah lokal harus tercatat audit.

## **8\. Plugin Faskes Tujuan ST/SPPD**

### **8.1 Tujuan**

Plugin faskes digunakan sebagai master fasilitas pelayanan kesehatan yang dapat menjadi tujuan Agenda, ST/SPPD, pembinaan, monitoring, dan dashboard.

### **8.2 Jenis Faskes Awal**

1. Puskesmas.  
2. Pustu.  
3. Poskesdes.  
4. Labkesda.  
5. Rumah sakit.  
6. Klinik.  
7. TPMD.  
8. Apotek.  
9. Faskes jejaring.  
10. Faskes lainnya sesuai kebutuhan.

### **8.3 Data Minimal Faskes**

Data minimal faskes:

1. Kode faskes bila tersedia.  
2. Nama faskes.  
3. Jenis faskes.  
4. Wilayah resmi.  
5. Wilayah lokal bila ada.  
6. Unit organisasi terkait bila UPTD.  
7. Alamat.  
8. Koordinat.  
9. Status aktif/nonaktif.  
10. Sumber data.

### **8.4 Aturan**

1. Faskes dapat dipilih sebagai tujuan ST/SPPD.  
2. Faskes dapat menjadi lokasi Agenda.  
3. Faskes dapat muncul pada dashboard.  
4. Faskes dapat memiliki wilayah kerja/wilayah binaan.  
5. Master faskes tidak boleh memuat data pasien.  
6. Kontak PIC faskes dibatasi sesuai kewenangan.

## **9\. Plugin Unit Organisasi**

### **9.1 Tujuan**

Plugin unit organisasi digunakan untuk mengelola struktur Dinas Kesehatan, bidang, sekretariat, subbag, tim kerja, UPTD, faskes, dan unit lainnya.

### **9.2 Fungsi**

1. Menentukan unit pembuat Agenda.  
2. Menentukan unit pengusul ST/SPPD.  
3. Menentukan unit pelaksana.  
4. Menentukan unit approval.  
5. Menentukan penomoran dokumen.  
6. Menentukan filter dashboard.  
7. Menjadi dasar ABAC.  
8. Menjadi dasar relasi pegawai dan faskes.

### **9.3 Aturan**

1. Unit organisasi memiliki parent-child.  
2. Unit dapat dikaitkan dengan faskes.  
3. Unit dapat dikaitkan dengan wilayah.  
4. Unit dapat memiliki pimpinan.  
5. Unit aktif/nonaktif harus jelas.  
6. Perubahan unit harus diaudit.

## **10\. Plugin Master Pegawai Lokal**

### **10.1 Tujuan**

Plugin master pegawai lokal digunakan sebagai referensi pegawai sebelum integrasi SIMPEG tersedia.

Plugin ini digunakan untuk:

1. Pelaksana ST/SPPD.  
2. Pemohon.  
3. Approver.  
4. Pejabat penandatangan.  
5. Reviewer.  
6. Verifikator bukti.  
7. Jurnal pegawai.  
8. Dashboard pegawai.  
9. Snapshot dokumen.

### **10.2 Data Minimal Pegawai**

1. Nama lengkap.  
2. NIP/nomor pegawai bila ada.  
3. Jabatan.  
4. Pangkat/golongan bila diperlukan.  
5. Unit organisasi.  
6. Faskes bila pegawai faskes.  
7. Relasi user login.  
8. Status aktif/nonaktif.  
9. Sumber data.

### **10.3 Snapshot Pegawai**

Saat pegawai digunakan dalam ST/SPPD final, sistem harus menyimpan snapshot:

1. Nama.  
2. NIP/nomor pegawai.  
3. Jabatan.  
4. Unit kerja.  
5. Pangkat/golongan bila diperlukan.  
6. Tanggal snapshot.

Snapshot diperlukan agar dokumen historis tidak berubah ketika data pegawai diperbarui.

## **11\. Plugin Pejabat Penandatangan dan Penomoran**

### **11.1 Tujuan**

Plugin ini mengelola:

1. Pejabat penandatangan.  
2. Kewenangan tanda tangan.  
3. Jenis dokumen yang dapat ditandatangani.  
4. Nomor ST.  
5. Nomor SPPD.  
6. Riwayat penggunaan nomor.  
7. Snapshot pejabat pada dokumen final.

### **11.2 Fungsi Penandatangan**

Data pejabat penandatangan digunakan pada:

1. Template ST.  
2. Template SPPD.  
3. Dokumen final.  
4. Approval akhir.  
5. Arsip.  
6. Integrasi TTE fase lanjutan.

### **11.3 Fungsi Penomoran**

Sistem penomoran digunakan untuk:

1. Nomor ST.  
2. Nomor SPPD.  
3. Nomor dokumen lain bila diperlukan.  
4. Penomoran berdasarkan tahun.  
5. Penomoran berdasarkan unit.  
6. Penomoran berdasarkan jenis dokumen.  
7. Pencegahan nomor ganda.  
8. Audit penggunaan nomor.

### **11.4 Aturan**

1. Nomor tidak boleh duplikat.  
2. Nomor yang sudah digunakan tidak boleh dipakai ulang tanpa mekanisme resmi.  
3. Nomor final harus tercatat.  
4. Pembatalan nomor harus memiliki alasan.  
5. Pejabat penandatangan harus disnapshot pada dokumen final.  
6. Perubahan pejabat tidak mengubah dokumen final lama.

## **12\. Plugin Master SPM/Program**

### **12.1 Tujuan**

Plugin master SPM/program digunakan untuk mengelola referensi:

1. SPM langsung.  
2. Pendukung SPM.  
3. Program prioritas.  
4. Program non-SPM.  
5. Indikator.  
6. Kategori kegiatan.

### **12.2 Fungsi**

Master SPM/program digunakan pada:

1. Agenda.  
2. ST/SPPD.  
3. Bukti tugas.  
4. Jurnal pegawai.  
5. Dashboard SPM.  
6. Monitoring kegiatan.  
7. Laporan bulanan/triwulan.  
8. Evaluasi efektivitas kunjungan.

### **12.3 Aturan**

1. Agenda/ST disarankan memiliki klasifikasi SPM/program.  
2. Jika tidak terkait SPM, user wajib memilih kategori non-SPM dan memberi alasan.  
3. Master SPM memiliki status aktif/nonaktif.  
4. Perubahan master SPM harus diaudit.  
5. Dashboard SPM harus menggunakan master ini, bukan input bebas.

## **13\. Plugin Kalender Hari Libur dan Cuti Bersama**

### **13.1 Tujuan**

Plugin kalender digunakan untuk mendukung validasi tanggal Agenda dan ST/SPPD.

### **13.2 Fungsi**

1. Menandai hari kerja.  
2. Menandai akhir pekan.  
3. Menandai hari libur nasional.  
4. Menandai cuti bersama.  
5. Menandai hari kerja khusus.  
6. Memberi peringatan jika ST/SPPD jatuh pada hari libur.  
7. Membantu perhitungan durasi SPPD.  
8. Membantu perencanaan agenda.

### **13.3 Prioritas**

Plugin ini masuk kategori **Should Have**. Tidak wajib menghambat MVP, tetapi sangat disarankan karena mendukung validasi tanggal.

## **14\. Plugin Master Transport/Alat Angkut**

### **14.1 Tujuan**

Plugin ini mengelola referensi alat angkut untuk kebutuhan SPPD.

Contoh:

1. Kendaraan dinas.  
2. Kendaraan pribadi.  
3. Travel.  
4. Kapal.  
5. Pesawat.  
6. Angkutan umum.  
7. Ojek.  
8. Lainnya.

### **14.2 Prioritas**

Plugin ini dapat dimulai sebagai enum/config sederhana pada MVP dan dikembangkan sebagai plugin penuh pada fase lanjutan.

## **15\. Plugin Template Approval Chain**

### **15.1 Tujuan**

Plugin template approval chain digunakan untuk mengatur alur approval yang berbeda berdasarkan:

1. Jenis dokumen.  
2. Unit organisasi.  
3. Faskes.  
4. Berbiaya/non-berbiaya.  
5. Kewenangan final.  
6. Kondisi khusus.

### **15.2 Prioritas**

Untuk MVP awal, approval chain dapat dibuat sederhana. Namun, jika alur Dinkes dan faskes berbeda signifikan, plugin ini perlu diprioritaskan sebagai **Should Have mendekati Must Have**.

## **16\. Koordinat Lokasi Agenda dan ST/SPPD**

### **16.1 Tujuan**

Koordinat lokasi digunakan untuk:

1. Lokasi agenda.  
2. Tujuan ST/SPPD.  
3. Dashboard peta.  
4. Monitoring kunjungan.  
5. Analisis wilayah binaan.  
6. Rekap faskes tujuan.  
7. Pengembangan geospatial fase lanjutan.

### **16.2 Tambahan Field pada Agenda**

Agenda perlu memiliki field lokasi terstruktur:

1. Wilayah resmi.  
2. Wilayah lokal.  
3. Faskes.  
4. Nama lokasi.  
5. Alamat manual.  
6. Latitude.  
7. Longitude.  
8. Sumber koordinat.  
9. Akurasi koordinat.

### **16.3 Tambahan Field pada Tujuan ST/SPPD**

Tujuan ST/SPPD perlu memiliki field:

1. Wilayah resmi tujuan.  
2. Wilayah lokal tujuan.  
3. Faskes tujuan.  
4. Nama tujuan.  
5. Alamat tujuan.  
6. Latitude.  
7. Longitude.  
8. Sumber koordinat.  
9. Akurasi koordinat.  
10. Penanda tujuan utama.

### **16.4 Aturan Koordinat**

1. Jika tujuan adalah faskes, koordinat default diambil dari master faskes.  
2. Jika tujuan adalah wilayah lokal, koordinat default diambil dari wilayah lokal.  
3. Jika tujuan hanya wilayah resmi, koordinat dapat diisi manual.  
4. Koordinat bukan tracking real-time pegawai.  
5. Koordinat bukti GPS tidak masuk MVP kecuali diputuskan.  
6. Koordinat lokasi sensitif tidak boleh dipublikasikan tanpa keputusan.  
7. Perubahan koordinat penting harus diaudit.

## **17\. Location Resolution Service**

Tambahkan service:

LocationResolutionService

Service ini menentukan lokasi default Agenda/ST/SPPD berdasarkan prioritas:

1\. Faskes

2\. Wilayah lokal

3\. Wilayah resmi

4\. Input manual

Output service minimal:

{

  "location\_name": "Nama Lokasi",

  "official\_region\_id": "official-region-id",

  "local\_region\_id": "local-region-id",

  "health\_facility\_id": "health-facility-id",

  "address\_text": "Alamat",

  "latitude": \-2.123456,

  "longitude": 111.123456,

  "coordinate\_source": "health\_facility"

}

## **18\. Dampak terhadap Arsitektur Plugin**

Dengan penambahan ini, urutan dependensi plugin menjadi:

official-region

→ local-region

→ organization-unit

→ personnel-master

→ health-facility

→ signatory-numbering

→ spm-master

→ agenda-dinkes

→ duty-travel

→ approval-template

→ document-template

→ evidence

→ journal

→ dashboard

→ archive

Artinya, plugin Agenda dan ST/SPPD tidak boleh berdiri sendiri tanpa referensi master data yang memadai.

## **19\. Dampak terhadap Database**

Tambahan tabel utama:

official\_regions

official\_region\_import\_batches

local\_regions

health\_facilities

health\_facility\_service\_areas

organization\_units

personnel

personnel\_snapshots

signatories

document\_numbering\_sequences

document\_numbering\_logs

spm\_programs

spm\_program\_links

calendar\_days

transport\_modes

approval\_templates

approval\_template\_steps

Tambahan relasi penting:

agenda\_events.official\_region\_id

agenda\_events.local\_region\_id

agenda\_events.health\_facility\_id

agenda\_events.organization\_unit\_id

duty\_request\_destinations.official\_region\_id

duty\_request\_destinations.local\_region\_id

duty\_request\_destinations.health\_facility\_id

duty\_requests.organization\_unit\_id

duty\_requests.spm\_program\_id

duty\_requests.signatory\_id

duty\_requests.numbering\_sequence\_id

duty\_request\_participants.personnel\_id

duty\_documents.signatory\_snapshot\_id

## **20\. Dampak terhadap API Service Contract**

Tambahkan API group:

/api/official-regions

/api/local-regions

/api/health-facilities

/api/organization-units

/api/personnel

/api/signatories

/api/document-numbering

/api/spm-programs

/api/calendar-days

/api/transport-modes

/api/approval-templates

Tambahkan service:

OfficialRegionService

LocalRegionService

HealthFacilityService

OrganizationUnitService

PersonnelService

PersonnelSnapshotService

SignatoryService

DocumentNumberingService

SpmProgramService

CalendarService

TransportModeService

ApprovalTemplateService

LocationResolutionService

## **21\. Dampak terhadap Dashboard dan KPI**

Dashboard MVP perlu menambahkan indikator:

1. Jumlah Agenda berdasarkan wilayah resmi.  
2. Jumlah ST berdasarkan wilayah resmi.  
3. Jumlah ST berdasarkan faskes tujuan.  
4. Jumlah ST berdasarkan unit organisasi.  
5. Jumlah ST berdasarkan SPM/program.  
6. Jumlah faskes yang sudah memiliki koordinat.  
7. Jumlah ST yang sudah memiliki koordinat tujuan.  
8. Coverage kegiatan per kecamatan/desa.  
9. Coverage kegiatan per faskes.  
10. Rekap pembinaan faskes.

KPI tambahan:

| Kode | Indikator | Target Pilot |
| ----- | ----- | ----- |
| MD-001 | Wilayah resmi tersedia | 100% wilayah target pilot |
| MD-002 | Wilayah lokal menginduk ke desa/kelurahan resmi | 100% |
| MD-003 | Faskes memiliki wilayah resmi | 100% faskes pilot |
| MD-004 | Faskes memiliki koordinat | ≥ 80% faskes pilot |
| MD-005 | ST memiliki tujuan terstruktur | ≥ 90% |
| MD-006 | ST memiliki koordinat lokasi | ≥ 80% pilot |
| MD-007 | Pegawai pelaksana menggunakan master pegawai | 100% pilot |
| MD-008 | Pejabat penandatangan menggunakan master | 100% dokumen final |
| MD-009 | Nomor dokumen tidak duplikat | 100% |
| MD-010 | Agenda/ST memiliki klasifikasi SPM/program | ≥ 90% |

## **22\. Dampak terhadap UAT**

Tambahkan skenario UAT:

### **UAT Tambahan 1 — Master Wilayah Resmi**

1. Admin dapat melihat wilayah resmi.  
2. Wilayah memiliki struktur provinsi → kabupaten/kota → kecamatan → desa/kelurahan.  
3. User biasa tidak dapat mengubah wilayah resmi.  
4. Import wilayah tercatat.  
5. Wilayah dapat dipilih pada Agenda/ST.

### **UAT Tambahan 2 — Master Wilayah Lokal**

1. Admin dapat membuat wilayah lokal.  
2. Wilayah lokal wajib menginduk ke desa/kelurahan resmi.  
3. Wilayah lokal dapat memiliki koordinat.  
4. Wilayah lokal dapat dipilih pada Agenda/ST.  
5. Perubahan wilayah lokal tercatat.

### **UAT Tambahan 3 — Master Faskes**

1. Admin dapat membuat/mengubah faskes.  
2. Faskes memiliki wilayah resmi.  
3. Faskes dapat memiliki koordinat.  
4. Faskes dapat dipilih sebagai tujuan ST.  
5. Dashboard dapat menampilkan rekap per faskes.

### **UAT Tambahan 4 — Koordinat Lokasi ST**

1. ST dari faskes mengambil koordinat faskes.  
2. ST dari wilayah lokal mengambil koordinat wilayah lokal bila tersedia.  
3. User dapat mengisi koordinat manual bila berwenang.  
4. Koordinat tersimpan pada tujuan ST.  
5. Koordinat tampil pada detail ST.  
6. Koordinat tidak menjadi tracking real-time pegawai.

### **UAT Tambahan 5 — Unit Organisasi**

1. Admin dapat membuat struktur unit.  
2. Unit dapat memiliki parent-child.  
3. User/pegawai dapat dikaitkan ke unit.  
4. Dashboard dapat difilter berdasarkan unit.  
5. ABAC unit berjalan.

### **UAT Tambahan 6 — Master Pegawai Lokal**

1. Admin dapat membuat pegawai.  
2. Pegawai dapat dikaitkan dengan user.  
3. Pegawai dapat dipilih sebagai pelaksana.  
4. Snapshot pegawai tersimpan pada ST.  
5. Perubahan master pegawai tidak mengubah dokumen final.

### **UAT Tambahan 7 — Pejabat Penandatangan dan Penomoran**

1. Admin dapat membuat pejabat penandatangan.  
2. Pejabat dapat dikaitkan dengan jenis dokumen.  
3. Nomor ST dapat digenerate.  
4. Nomor SPPD dapat digenerate.  
5. Nomor tidak ganda.  
6. Log penomoran tercatat.

### **UAT Tambahan 8 — Master SPM/Program**

1. Admin dapat membuat master SPM/program.  
2. Agenda dapat dikaitkan ke SPM/program.  
3. ST dapat dikaitkan ke SPM/program.  
4. Dashboard SPM menggunakan master tersebut.  
5. Data non-SPM tetap dapat diberi alasan.

## **23\. Dampak terhadap Sprint Plan**

Tambahkan pada Sprint 1:

S1-006 Implementasi plugin official-region

S1-007 Implementasi plugin local-region

S1-008 Implementasi plugin organization-unit

S1-009 Implementasi plugin personnel-master

S1-010 Implementasi plugin health-facility

S1-011 Implementasi plugin signatory-numbering

S1-012 Implementasi plugin spm-master

Tambahkan pada Sprint 2:

S2-007 Tambahkan relasi agenda ke official-region, local-region, health-facility, dan organization-unit

S2-008 Tambahkan koordinat lokasi agenda

S2-009 Tambahkan relasi agenda ke spm-master

Tambahkan pada Sprint 3:

S3-006 Tambahkan faskes tujuan ST/SPPD

S3-007 Tambahkan wilayah resmi/lokal tujuan ST/SPPD

S3-008 Tambahkan koordinat lokasi tujuan ST/SPPD

S3-009 Tambahkan relasi pelaksana ke personnel-master

S3-010 Tambahkan relasi ST/SPPD ke signatory-numbering

S3-011 Tambahkan relasi ST/SPPD ke spm-master

Tambahkan pada Sprint 4:

S4-006 Gunakan signatory snapshot pada PDF ST/SPPD

S4-007 Gunakan numbering sequence untuk nomor ST/SPPD

S4-008 Siapkan approval-template sederhana bila workflow berbeda per unit/faskes

Tambahkan pada Sprint 5:

S5-006 Dashboard rekap ST berdasarkan wilayah resmi

S5-007 Dashboard rekap ST berdasarkan faskes tujuan

S5-008 Dashboard rekap ST berdasarkan unit organisasi

S5-009 Dashboard rekap ST berdasarkan SPM/program

S5-010 Struktur awal dashboard peta bila memungkinkan

## **24\. Dampak terhadap Security dan Privacy**

Aturan tambahan:

1. Koordinat ST tidak boleh digunakan sebagai tracking real-time pegawai.  
2. Koordinat lokasi sensitif tidak boleh dipublikasikan tanpa keputusan.  
3. Data pegawai hanya ditampilkan sesuai kebutuhan.  
4. Kontak pribadi pegawai tidak boleh tampil di dashboard umum.  
5. Master faskes tidak boleh memuat data pasien.  
6. Data PIC faskes harus dibatasi.  
7. Wilayah resmi hanya dapat diimport/manage oleh admin berwenang.  
8. Wilayah lokal dapat dikelola sesuai permission.  
9. Pejabat penandatangan harus memiliki snapshot pada dokumen final.  
10. Nomor dokumen tidak boleh diubah bebas setelah final.  
11. Master SPM harus memiliki status aktif/nonaktif.  
12. Dashboard publik tidak boleh menampilkan data detail pegawai/faskes sensitif.  
13. Perubahan master data penting harus audit.  
14. Export master pegawai/faskes dibatasi.  
15. Import master data harus memiliki log batch.

## **25\. Prioritas Implementasi Final**

### **25.1 Wajib Masuk MVP Foundation**

1. Plugin wilayah resmi.  
2. Plugin faskes.  
3. Plugin unit organisasi.  
4. Plugin master pegawai lokal.  
5. Plugin pejabat penandatangan dan penomoran.  
6. Plugin master SPM/program.

### **25.2 Sangat Direkomendasikan Masuk MVP Jika Tidak Membebani**

1. Plugin wilayah lokal.  
2. Koordinat lokasi ST/SPPD.  
3. Koordinat faskes.  
4. Location Resolution Service.  
5. Template approval sederhana.

### **25.3 Dapat Masuk Fase Lanjutan**

1. GeoJSON batas wilayah.  
2. Dashboard peta interaktif.  
3. Import otomatis berkala wilayah resmi.  
4. Integrasi otomatis sumber faskes resmi.  
5. Kalender hari libur otomatis.  
6. Master transport penuh.  
7. Approval template kompleks.  
8. Integrasi SIMPEG.  
9. Integrasi SATUSEHAT/Khanza.  
10. Integrasi GIS lanjutan.

## 

## **26\. Pembaruan Alur Data PRD**

Dengan tambahan fondasi master data, alur data Satu Sehat Kobar menjadi:

Wilayah Resmi

→ Wilayah Lokal

→ Faskes

→ Unit Organisasi

→ Pegawai

→ Pejabat Penandatangan

→ Penomoran

→ SPM/Program

→ Agenda

→ ST/SPPD \+ Koordinat

→ Approval

→ PDF

→ Upload Final

→ Bukti

→ Verifikasi

→ Jurnal

→ Dashboard Wilayah/Faskes/SPM

→ Arsip

## **27\. Kesimpulan Tambahan PRD**

Penambahan fondasi master data ini membuat PRD v1.4 lebih lengkap dan lebih siap diimplementasikan.

Tanpa fondasi master data, sistem tetap dapat membuat Agenda dan ST/SPPD, tetapi akan berisiko:

1. Lokasi tidak standar.  
2. Faskes tujuan tidak konsisten.  
3. Dashboard wilayah/faskes kurang valid.  
4. Data pegawai dan pejabat tidak historis.  
5. Nomor dokumen berisiko tidak terkendali.  
6. SPM/program menjadi input bebas.  
7. Integrasi fase lanjutan lebih sulit.

Dengan tambahan ini, Satu Sehat Kobar tidak hanya menjadi sistem administrasi ST/SPPD, tetapi menjadi platform kerja internal berbasis data yang siap untuk dashboard, pembinaan faskes, monitoring SPM, monitoring RME/SATUSEHAT, dan integrasi sistem kesehatan daerah secara bertahap.

