require 'rspec'
require 'rakemkv'
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

module RakeMKVMock
  def self.info
    <<-EOS
    MSG:1005,0,1,"MakeMKV v1.8.3 linux(x64-release) started","%1 started","MakeMKV v1.8.3 linux(x64-release)"
    DRV:0,2,999,1,"DVD+R-DL MATSHITA DVD-RAM UJ8C2 SB01","TRANFORMERS","/dev/sr0"
    DRV:1,256,999,0,"","",""
    DRV:2,256,999,0,"","",""
    DRV:3,256,999,0,"","",""
    DRV:4,256,999,0,"","",""
    DRV:5,256,999,0,"","",""
    DRV:6,256,999,0,"","",""
    DRV:7,256,999,0,"","",""
    DRV:8,256,999,0,"","",""
    DRV:9,256,999,0,"","",""
    DRV:10,256,999,0,"","",""
    DRV:11,256,999,0,"","",""
    DRV:12,256,999,0,"","",""
    DRV:13,256,999,0,"","",""
    DRV:14,256,999,0,"","",""
    DRV:15,256,999,0,"","",""
    MSG:3007,0,0,"Using direct disc access mode","Using direct disc access mode"
    MSG:3028,0,3,"Title #1 was added (16 cell(s), 1:10:22)","Title #%1 was added (%2 cell(s), %3)","1","16","1:10:22"
    MSG:3028,0,3,"Title #2 was added (1 cell(s), 0:10:22)","Title #%1 was added (%2 cell(s), %3)","2","1","0:10:22"
    MSG:3025,0,3,"Title #3 has length of 8 seconds which is less than minimum title length of 120 seconds and was therefore skipped","Title #%1 has length of %2 seconds which is less than minimum title length of %3 seconds and was therefore skipped","3","8","120"
    MSG:3025,0,3,"Title #4 has length of 10 seconds which is less than minimum title length of 120 seconds and was therefore skipped","Title #%1 has length of %2 seconds which is less than minimum title length of %3 seconds and was therefore skipped","4","10","120"
    MSG:3025,0,3,"Title #5 has length of 26 seconds which is less than minimum title length of 120 seconds and was therefore skipped","Title #%1 has length of %2 seconds which is less than minimum title length of %3 seconds and was therefore skipped","5","26","120"
    MSG:3031,16777216,1,"Drive DVD+R-DL MATSHITA DVD-RAM UJ8C2 SB01 has RPC protection that can not be bypassed. Change drive region or update drive firmware from http://tdb.rpc1.org. Errors likely to follow.","Drive %1 has RPC protection that can not be bypassed. Change drive region or update drive firmware from http://tdb.rpc1.org. Errors likely to follow.","DVD+R-DL MATSHITA DVD-RAM UJ8C2 SB01"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_01_1.VOB' at offset '2048'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_01_1.VOB","2048"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_01_1.VOB' at offset '2048'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_01_1.VOB","2048"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_01_1.VOB' at offset '2048'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_01_1.VOB","2048"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_01_1.VOB' at offset '2048'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_01_1.VOB","2048"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_01_1.VOB' at offset '2048'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_01_1.VOB","2048"
    MSG:3031,0,1,"Drive DVD+R-DL MATSHITA DVD-RAM UJ8C2 SB01 has RPC protection that can not be bypassed. Change drive region or update drive firmware from http://tdb.rpc1.org. Errors likely to follow.","Drive %1 has RPC protection that can not be bypassed. Change drive region or update drive firmware from http://tdb.rpc1.org. Errors likely to follow.","DVD+R-DL MATSHITA DVD-RAM UJ8C2 SB01"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_02_1.VOB' at offset '4096'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_02_1.VOB","4096"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_02_1.VOB' at offset '4096'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_02_1.VOB","4096"
    MSG:2003,16777216,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_02_1.VOB' at offset '4096'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_02_1.VOB","4096"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_02_1.VOB' at offset '4096'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_02_1.VOB","4096"
    MSG:2003,0,3,"Error 'Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION' occurred while reading '/VIDEO_TS/VTS_02_1.VOB' at offset '4096'","Error '%1' occurred while reading '%2' at offset '%3'","Scsi error - ILLEGAL REQUEST:MEDIA REGION CODE IS MISMATCHED TO LOGICAL UNIT REGION","/VIDEO_TS/VTS_02_1.VOB","4096"
    MSG:5010,0,0,"Failed to open disc","Failed to open disc"
    TCOUNT:0
    EOS
  end
end
