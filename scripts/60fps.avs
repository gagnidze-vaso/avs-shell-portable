file_path="C:\Users\Admin\Desktop\asd.mp4"
svp=3		#  =  1 - low | 2 - medium (default) | 3 - high
alg=1		#  =  0 - blocks | 1 - standard (default) | 2 - simple | 3 - complex
fim=3		#  =  0 - limits | 1 - average | 2 - adaptive (default) | 3 - uniform
am=0		#  =  0 - off (default) | 1 - low | 2 - high
uhd=1		#  =  0 - off (default) | 1 - ultra hd video support
gpu=1		#  =  0 - off | 1 - first gpu (default) | 2 - second gpu
fps=60		#  =  60 (default) | 2 - x2 fps | 50 ... 120 - target fps

# SVPflow plugin for PotPlayer
# Check https://www.svp-team.com/wiki/Manual:SVPflow for more details
# This script was created by zub35 and 7sh3

SetMemoryMax(2700)
global threads = (gpu>=1) ? 7 : 5

LoadPlugin("../plugins/svpflow1.dll")
LoadPlugin("../plugins/svpflow2.dll")

SetFilterMTMode("DEFAULT_MT_MODE",2)
SetFilterMTMode("SVSuper",1)
SetFilterMTMode("SVAnalyse",1)

LoadPlugin("../plugins/ffms2.dll")

video=FFVideoSource(file_path)
audio=FFAudioSource(file_path)
AudioDub(video, audio)

gpuid = (gpu==2) ? "gpuid:21" : "gpuid:0"

fps == 2 ? eval("""
rate = "num:2,den:1"
""") : fps >= 50 ? eval("""
rate = "num:"+String(ContinuedNumerator(fps/Framerate,limit=10))+",den:"+String(ContinuedDenominator(fps/Framerate,limit=10))
""") : eval("""
rate = "num:1,den:1"
""") 

fim == 1 ? eval("""
scene = "mode:1"
""") : fim == 2 ? eval("""
scene = "mode:3"
""") : fim == 3 ? eval("""
scene = "mode:0"
""") : eval("""
scene = "limits:{m1:0,m2:900,scene:2000}"
""")

alg == 1 ? eval("""
algo = "algo:13"
""") : alg == 2 ? eval("""
algo = "algo:21"
""") : alg == 3 ? eval("""
algo = "algo:23"
""") : eval("""
algo = (gpu>=1) ? "algo:11" : "algo:11,block:true"
""")

am == 1 ? eval("""
mask = "area:50"
""") : am == 2 ? eval("""
mask = "area:100"
""") : eval("""
mask = ""
""")

alg == 2 ? eval("""
cover = (am>=1) ? ",cover:80" : "cover:80"
""") : alg == 3 ? eval("""
cover = (am>=1) ? ",cover:80" : "cover:80"
""") : eval("""
cover = ""
""")

svp == 1 ? eval("""
super_params_gpu_sd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""") : svp == 2 ? eval("""
super_params_gpu_sd = "{scale:{up:0},gpu:1}"
""") : svp == 3 ? eval("""
super_params_gpu_sd = "{scale:{up:0},gpu:1}"
""") : svp == 4 ? eval("""
super_params_gpu_sd = "{scale:{up:0},gpu:1}"
""") : eval("""
super_params_gpu_sd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""")
svp == 1 ? eval("""
super_params_cpu_sd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 2 ? eval("""
super_params_cpu_sd = "{scale:{up:2},gpu:0}"
""") : svp == 3 ? eval("""
super_params_cpu_sd = "{scale:{up:2},gpu:0}"
""") : svp == 4 ? eval("""
super_params_cpu_sd = "{scale:{up:2},gpu:0}"
""") : eval("""
super_params_cpu_sd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""")

svp == 1 ? eval("""
analyse_params_gpu_sd = "{block:{overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_gpu_sd = "{}"
""") : svp == 3 ? eval("""
analyse_params_gpu_sd = "{main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}},refine:[{thsad:250}]}"
""") : svp == 4 ? eval("""
analyse_params_gpu_sd = "{block:{w:8},main:{search:{coarse:{bad:{sad:2000}}}},refine:[{thsad:250}]}"
""") : eval("""
analyse_params_gpu_sd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")
svp == 1 ? eval("""
analyse_params_cpu_sd = "{block:{overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_cpu_sd = "{}"
""") : svp == 3 ? eval("""
analyse_params_cpu_sd = "{main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}},refine:[{thsad:250}]}"
""") : svp == 4 ? eval("""
analyse_params_cpu_sd = "{block:{w:8},main:{search:{coarse:{bad:{sad:2000}}}}}"
""") : eval("""
analyse_params_cpu_sd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")

svp == 1 ? eval("""
smoothfps_params_gpu_sd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_gpu_sd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_gpu_sd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_gpu_sd = "{"""+gpuid+""",rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_gpu_sd = "{"""+gpuid+""",cubic:0,linear:false,rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")
svp == 1 ? eval("""
smoothfps_params_cpu_sd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_cpu_sd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_cpu_sd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_cpu_sd = "{rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_cpu_sd = "{rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")

svp == 1 ? eval("""
super_params_gpu_hd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""") : svp == 2 ? eval("""
super_params_gpu_hd = "{scale:{up:0},gpu:1}"
""") : svp == 3 ? eval("""
super_params_gpu_hd = "{scale:{up:0},gpu:1}"
""") : svp == 4 ? eval("""
super_params_gpu_hd = "{scale:{up:0},gpu:1}"
""") : eval("""
super_params_gpu_hd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""")
svp == 1 ? eval("""
super_params_cpu_hd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 2 ? eval("""
super_params_cpu_hd = "{scale:{up:2},gpu:0}"
""") : svp == 3 ? eval("""
super_params_cpu_hd = "{scale:{up:2},gpu:0}"
""") : svp == 4 ? eval("""
super_params_cpu_hd = "{scale:{up:2},gpu:0}"
""") : eval("""
super_params_cpu_hd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""")

svp == 1 ? eval("""
analyse_params_gpu_hd = "{block:{overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_gpu_hd = "{}"
""") : svp == 3 ? eval("""
analyse_params_gpu_hd = "{main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}},refine:[{thsad:250}]}"
""") : svp == 4 ? eval("""
analyse_params_gpu_hd = "{block:{w:8},main:{search:{coarse:{bad:{sad:2000}}}},refine:[{thsad:250}]}"
""") : eval("""
analyse_params_gpu_hd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")
svp == 1 ? eval("""
analyse_params_cpu_hd = "{block:{overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_cpu_hd = "{}"
""") : svp == 3 ? eval("""
analyse_params_cpu_hd = "{main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}},refine:[{thsad:250}]}"
""") : svp == 4 ? eval("""
analyse_params_cpu_hd = "{block:{w:8},main:{search:{coarse:{bad:{sad:2000}}}}}"
""") : eval("""
analyse_params_cpu_hd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")

svp == 1 ? eval("""
smoothfps_params_gpu_hd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_gpu_hd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_gpu_hd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_gpu_hd = "{"""+gpuid+""",rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_gpu_hd = "{"""+gpuid+""",cubic:0,linear:false,rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")
svp == 1 ? eval("""
smoothfps_params_cpu_hd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_cpu_hd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_cpu_hd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_cpu_hd = "{rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_cpu_hd = "{rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")

svp == 1 ? eval("""
super_params_gpu_fhd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""") : svp == 2 ? eval("""
super_params_gpu_fhd = "{scale:{up:0},gpu:1}"
""") : svp == 3 ? eval("""
super_params_gpu_fhd = "{scale:{up:0},gpu:1}"
""") : svp == 4 ? eval("""
super_params_gpu_fhd = "{scale:{up:0},gpu:1}"
""") : eval("""
super_params_gpu_fhd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""")
svp == 1 ? eval("""
super_params_cpu_fhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 2 ? eval("""
super_params_cpu_fhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 3 ? eval("""
super_params_cpu_fhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 4 ? eval("""
super_params_cpu_fhd = "{scale:{up:2},gpu:0}"
""") : eval("""
super_params_cpu_fhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""")

svp == 1 ? eval("""
analyse_params_gpu_fhd = "{block:{w:32,overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_gpu_fhd = "{block:{overlap:0}}"
""") : svp == 3 ? eval("""
analyse_params_gpu_fhd = "{main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}},refine:[{thsad:250}]}"
""") : svp == 4 ? eval("""
analyse_params_gpu_fhd = "{main:{search:{coarse:{bad:{sad:2000}}}},refine:[{thsad:250}]}"
""") : eval("""
analyse_params_gpu_fhd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")
svp == 1 ? eval("""
analyse_params_cpu_fhd = "{block:{w:32,overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_cpu_fhd = "{block:{overlap:0}}"
""") : svp == 3 ? eval("""
analyse_params_cpu_fhd = "{main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}}}"
""") : svp == 4 ? eval("""
analyse_params_cpu_fhd = "{main:{search:{coarse:{bad:{sad:2000}}}},refine:[{thsad:250}]}"
""") : eval("""
analyse_params_cpu_fhd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")

svp == 1 ? eval("""
smoothfps_params_gpu_fhd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_gpu_fhd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_gpu_fhd = "{"""+gpuid+""",rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_gpu_fhd = "{"""+gpuid+""",rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_gpu_fhd = "{"""+gpuid+""",cubic:0,linear:false,rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")
svp == 1 ? eval("""
smoothfps_params_cpu_fhd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_cpu_fhd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_cpu_fhd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_cpu_fhd = "{rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_cpu_fhd = "{rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")

svp == 1 ? eval("""
super_params_gpu_uhd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""") : svp == 2 ? eval("""
super_params_gpu_uhd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""") : svp == 3 ? eval("""
super_params_gpu_uhd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""") : svp == 4 ? eval("""
super_params_gpu_uhd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""") : eval("""
super_params_gpu_uhd = "{pel:1,scale:{up:0},gpu:1,full:false}"
""")
svp == 1 ? eval("""
super_params_cpu_uhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 2 ? eval("""
super_params_cpu_uhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 3 ? eval("""
super_params_cpu_uhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : svp == 4 ? eval("""
super_params_cpu_uhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""") : eval("""
super_params_cpu_uhd = "{pel:1,scale:{up:2},gpu:0,full:false}"
""")

svp == 1 ? eval("""
analyse_params_gpu_uhd = "{block:{w:32,overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_gpu_uhd = "{block:{w:32,overlap:0}}"
""") : svp == 3 ? eval("""
analyse_params_gpu_uhd = "{block:{overlap:0},main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}}}"
""") : svp == 4 ? eval("""
analyse_params_gpu_uhd = "{main:{search:{coarse:{bad:{sad:2000}}}},refine:[{thsad:250}]}"
""") : eval("""
analyse_params_gpu_uhd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")
svp == 1 ? eval("""
analyse_params_cpu_uhd = "{block:{w:32,overlap:0},main:{search:{coarse:{satd:false,bad:{range:0},width:530},type:2}}}"
""") : svp == 2 ? eval("""
analyse_params_cpu_uhd = "{block:{w:32,overlap:0}}"
""") : svp == 3 ? eval("""
analyse_params_cpu_uhd = "{block:{overlap:0},main:{search:{coarse:{distance:-8,bad:{sad:2000,range:24}},type:2}}}"
""") : svp == 4 ? eval("""
analyse_params_cpu_uhd = "{main:{search:{coarse:{bad:{sad:2000}}}},refine:[{thsad:250}]}"
""") : eval("""
analyse_params_cpu_uhd = "{vectors:2,block:{overlap:0},main:{search:{coarse:{type:2,distance:-6},distance:0}}}"
""")

svp == 1 ? eval("""
smoothfps_params_gpu_uhd = "{"""+gpuid+""",cubic:0,linear:false,rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_gpu_uhd = "{"""+gpuid+""",cubic:0,linear:false,rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_gpu_uhd = "{"""+gpuid+""",cubic:0,linear:false,rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_gpu_uhd = "{"""+gpuid+""",rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_gpu_uhd = "{"""+gpuid+""",cubic:0,linear:false,rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")
svp == 1 ? eval("""
smoothfps_params_cpu_uhd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 2 ? eval("""
smoothfps_params_cpu_uhd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 3 ? eval("""
smoothfps_params_cpu_uhd = "{rate:{"""+rate+"""},"""+algo+""",mask:{"""+mask+""""""+cover+"""},scene:{"""+scene+"""}}"
""") : svp == 4 ? eval("""
smoothfps_params_cpu_uhd = "{rate:{"""+rate+"""},algo:21,mask:{area:50,cover:80},scene:{mode:0}}"
""") : eval("""
smoothfps_params_cpu_uhd = "{rate:{"""+rate+"""},algo:1,mask:{},scene:{mode:1}}"
""")

z = width * height

z <= 450000 ? eval("""
global super_params = (gpu>=1) ? """"+super_params_gpu_sd+"""" : """"+super_params_cpu_sd+""""
global analyse_params = (gpu>=1) ? """"+analyse_params_gpu_sd+"""" : """"+analyse_params_cpu_sd+""""
global smoothfps_params = (gpu>=1) ? """"+smoothfps_params_gpu_sd+"""" : """"+smoothfps_params_cpu_sd+""""
""") : z <= 1100000 ? eval("""
global super_params = (gpu>=1) ? """"+super_params_gpu_hd+"""" : """"+super_params_cpu_hd+""""
global analyse_params = (gpu>=1) ? """"+analyse_params_gpu_hd+"""" : """"+analyse_params_cpu_hd+""""
global smoothfps_params = (gpu>=1) ? """"+smoothfps_params_gpu_hd+"""" : """"+smoothfps_params_cpu_hd+""""
""") : z <= 2305000 ? eval("""
global super_params = (gpu>=1) ? """"+super_params_gpu_fhd+"""" : """"+super_params_cpu_fhd+""""
global analyse_params = (gpu>=1) ? """"+analyse_params_gpu_fhd+"""" : """"+analyse_params_cpu_fhd+""""
global smoothfps_params = (gpu>=1) ? """"+smoothfps_params_gpu_fhd+"""" : """"+smoothfps_params_cpu_fhd+""""
""") : eval("""
global super_params = (gpu>=1) ? """"+super_params_gpu_uhd+"""" : """"+super_params_cpu_uhd+""""
global analyse_params = (gpu>=1) ? """"+analyse_params_gpu_uhd+"""" : """"+analyse_params_cpu_uhd+""""
global smoothfps_params = (gpu>=1) ? """"+smoothfps_params_gpu_uhd+"""" : """"+smoothfps_params_cpu_uhd+""""
""")

function interpolate(clip src)
{
super = SVSuper(src, super_params)
vectors = SVAnalyse(super, analyse_params, src)
SVSmoothFps(src, super, vectors, smoothfps_params, mt=threads)
}

Framerate > 30.5 ? eval("""

""") : z < 2305000 ? eval(""" 
interpolate()
""") : z < 8300000 && uhd == 1 ? eval(""" 
interpolate()
""") : eval("""

""")

Prefetch(threads)

# WriteFileStart("params.txt","super_params","chr(10)","analyse_params","chr(10)","smoothfps_params")
