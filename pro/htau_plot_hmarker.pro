PRO HTAU_PLOT_HMARKER,vv,yrange
;+
;   mark H2 lines from different vibration level
;-
COMMON htau,htau_data,htau_grid
cspeed=!CONST.C/1d3

xyouts,'!6'
;+
; ylevel:   y level where tick marks will grow
; lev:      1 = upper line, ticks grow down
;          -1 = lower line, ticks grow up 
; cvel:     componnet velocity
; spec:     species
; cc:       color
; ticklen:  mark length in data units
;-

;cvel=[10,272,10,272,10,272,10,272]
;spec=['H2','H2','HD','HD','H I','H I','D I','D I']
;lev=[1,-1,1,-1,1,-1,1,-1]
;cc=['blue','red','blue','red','blue','red','black','blue']
;ylevel=[2.5,-1.5,2.0,-1.0,0.3,1.3,-0.3]
;ticklen=[0.5,0.5,0.5,0.5,0.3,0.3,0.2,0.2]

if  n_elements(vv) eq 1 then begin
    cvel=[vv[0],vv[0],vv[0]]
    spec=['H2','H I','HD']
    lev=[1,1,-1]
    cc=['blue','red','red']
    ylevel=[0.9,0.6,0.0]*(yrange[1]-yrange[0])+yrange[0]
    ticklen=[0.1,0.1,0.05]*(yrange[1]-yrange[0])
endif

if  n_elements(vv) eq 1 then begin
    cvel=[vv[0],vv[0],vv[0]]
    spec=['H2','H I']
    lev=[1,1]
    cc=['blue','red']
    ylevel=[0.9,0.6]*(yrange[1]-yrange[0])+yrange[0]
    ticklen=[0.1,0.1]*(yrange[1]-yrange[0])
endif

if  n_elements(vv) eq 2 then begin
    cvel=[vv[0],vv[1],vv[0],vv[1],vv[0],vv[1]]
    spec=['H2','H2','H I','H I','HD','HD']
    lev=[1,-1,1,-1,-1,-1]
    cc=['blue','red','blue','red','blue','red']
    ylevel=[0.9,0.1,0.6,0.3,0.0,0.0]*(yrange[1]-yrange[0])+yrange[0]
    ticklen=[0.1,0.1,0.1,0.1,0.05,0.05]*(yrange[1]-yrange[0])
endif

if  n_elements(vv) eq 3 then begin
    cvel=[vv[0],vv[1],vv[2],vv[0],vv[1],vv[2],vv[0],vv[1],vv[2]]
    spec=['H2','H2','H2','H I','H I','H I','HD','HD','HD']
    lev=[1,1,-1,1,1,-1,-1,-1,-1]
    cc=['blue','purple','red','blue','purple','red','blue','purple','red']
    ylevel=[0.9,0.9,0.1,0.6,0.6,0.3,0.0,0.0,0.0]*(yrange[1]-yrange[0])+yrange[0]
    ticklen=[0.1,0.1,0.1,0.1,0.1,0.1,0.05,0.05,0.05]*(yrange[1]-yrange[0])
endif
;cvel=[vv[0],vv[1],vv[0],vv[1],vv[0],vv[1]]
;spec=['H2','H2','H I','H I','HD','HD']
;lev=[1,-1,1,-1,-1,-1]
;cc=['blue','red','blue','red','blue','red']
;ylevel=[0.4,0.6,0.4,0.6,0.0,0.0]*(yrange[1]-yrange[0])+yrange[0]
;ticklen=[0.3,0.3,0.3,0.3,0.05,0.05]*(yrange[1]-yrange[0])
;
;cvel=[vv[0],vv[1],vv[0],vv[1],vv[0],vv[1]]
;spec=['H2','H2','H I','H I','Ar I','Ar I']
;lev=[1,1,1,-1,-1,-1]
;cc=['slate gray','red','blue','red','blue','red']
;ylevel=[0.4,0.8,0.4,0.6,0.4,0.6]*(yrange[1]-yrange[0])+yrange[0]
;ticklen=[0.3,0.3,0.3,0.3,0.3,0.3]*(yrange[1]-yrange[0])

;T=SYSTIME(1)
tag=where(htau_data.nl eq 'X' and $
    htau_data.nvl eq '0' and $
    float(htau_data.nvu) le 50 and $
    (htau_data.spec eq 'H2' or htau_data.spec eq 'HD') and $
    float(htau_data.njl) le 50)
; and strmid(htau_data.name,4,4) ne 'P(3)' 
htau_data_nl=(htau_data.nl)[tag]
htau_data_nu=(htau_data.nu)[tag]
htau_data_nvl=(htau_data.nvl)[tag]
htau_data_nvu=(htau_data.nvu)[tag]
htau_data_njl=(htau_data.njl)[tag]
htau_data_nju=(htau_data.nju)[tag]
htau_data_spec=(htau_data.spec)[tag]
htau_data_name=(htau_data.name)[tag]
htau_data_wl=(htau_data.wl)[tag]

;print, '>> total time:   ',strtrim(string((SYSTIME(1)-T)),2), 'S'    
for s=0,n_elements(spec)-1 do begin

; FOR HI or DI
if  spec[s] eq 'H I' or spec[s] eq 'D I' then begin     
    tag=where(  htau_data.nl eq '1' and $
                htau_data.spec eq spec[s])
    wl=htau_data[tag].wl
    nu=htau_data[tag].nu
    name=htau_data[tag].name
    for k=0,n_elements(wl)-1 do begin
        wls=wl[k]*cspeed/(cspeed-cvel[s])-wl[k]
        oplot,[wl[k],wl[k]]+wls,ylevel[s]+[0.0,-ticklen[s]*lev[s]],color=cgcolor(cc[s])
        ;print,[wl[k],wl[k]]+wls
        if  lev[s] eq 1 and nu[k] le 8 then begin
            xyouts,wl[k]+wls,ylevel[s]+ticklen[s]*lev[s]*1.2,name[k],$
                ori=90,color=cgcolor(cc[s]),charsize=2.0
            print,name[k]
        endif
    endfor
endif




;print,'line-->',n_elements(tag)

; FOR H2 or HD
nu_loop=['B','C']
nvu_loop=strtrim(indgen(30),2)

if  spec[s] eq 'H2' or spec[s] eq 'HD' then begin
    if spec[s] eq 'H2' then jmax=6.0
    if spec[s] eq 'HD' then jmax=1.0
    ;
    for i=0,n_elements(nu_loop)-1 do begin
        for j=0,n_elements(nvu_loop)-1 do begin
            
            tag=where(  htau_data_spec eq spec[s] and $
                htau_data_nu eq nu_loop[i] and $
                htau_data_nvu eq nvu_loop[j] and $
                float(htau_data_njl) le jmax )
            ;
            wl=htau_data_wl[tag]
            ;print,min(wl)
            name=htau_data_name[tag]
            njl=float(htau_data_njl[tag])
            lc=[]
            if  tag[0] ne -1 then begin
                if  j mod 2 eq 1 then adj=-ticklen[s]*1.5*lev[s] else adj=0.0
                for k=0,n_elements(wl)-1 do begin
                    
                    wls=wl*cvel[s]/cspeed
                    ticklen_scale=(10.-njl[k])/10
                    oplot,[wl[k],wl[k]]+wls,ylevel[s]+adj+[0.,-ticklen[s]]*lev[s]*ticklen_scale,color=cgcolor(cc[s])
                    lc=[lc,wl[k]+wls]
                    if not (spec[s] eq 'H2' and cvel[s] gt 100)  then continue
                    xyouts,[wl[k],wl[k]]+(min(wls)+max(wls))/2,0.9,strmid(name[k],4,4),charsize=0.7,ori=0,noclip=1,ali=0.5
                    
                endfor
                oplot,[min(lc),max(lc)],[ylevel[s],ylevel[s]]+adj,color=cgcolor(cc[s])
                if  lev[s] eq 1 then begin
                    if nu_loop[i] eq 'B' then bandname='L'
                    if nu_loop[i] eq 'C' then bandname='W'
                    bandname=bandname+nvu_loop[j]+'-0'
                    xyouts,[min(lc)+max(lc)]/2,ylevel[s]+adj,bandname,ali=0.5
                endif
            endif
            
        endfor
    endfor
    ;
endif

endfor




END

PRO TEST_HTAU_PLOT_HMARKER

RESOLVE_ROUTINE,'htau_grid_plot'
htau_grid_plot

END
;
;tag=where(line.spec eq 'D I')
;for i=0,n_elements(tag)-1 do begin
;    print,line[tag[i]]
;endfor
;
;;htau_plot_h2marker,
;
;;at,ivelc,clist=clist,thick=thick, yrange=yrange,$
;;noseg=noseg
;
;;COMMON molec_data 
;;COMMON atom_data
;;COMMON hd_data 
;
;; default color table
;
;if (n_elements(clist) eq 0) then colorlist=cgcolor(['red','blue','cyan','yellow'])
;if (n_elements(clist) ne 0) then colorlist=cgcolor(clist)
;if (n_elements(thick) eq 0) then thick=6.0
;if (n_elements(yrange) eq 0) then yrange=[-0.5,1.5]
;
;; for molecular lines, low rank lines turned on only
;;bandnames=strsplit(molec_names,'R|P|Q',/regex,/ex)
;;bandnames=bandnames->toarray()
;;bandnames=bandnames[*,0]
;
;band_list=[replicate('L',20),replicate('W',6)]
;uvib_list=[indgen(20),indgen(6)]
;;band_list=replicate('L',21)
;;uvib_list=indgen(21)
;dl=(yrange[1]-yrange[0])
;
;; loop through different bands
;for i=0,n_elements(band_list)-1 do begin
; 
;  tag=where( h2.uvib eq uvib_list[i] and $
;             h2.band eq band_list[i] and $
;             h2.lrot le 6)
;  tag_hd=where( hd.uvib eq uvib_list[i] and $
;                hd.lrot le 6 ) 
;  h2label=band_list[i]+strtrim(uvib_list[i],2)
;  mky=yrange[1]-dl*(0.25-0.1*(i mod 3))
;  mky_label=mky-dl*0.08
;
;
;  for k=0,n_elements(ivelc)-1 do begin
;    mk_wl=(ivelc[k]/3.e5+1.0)*h2.wl
;    for j=0,n_elements(tag)-1 do begin
;      mky_end=mky-dl*0.16*(8-h2.lrot[tag[j]])/8
;      tmpthick=thick
;      if h2.lrot[tag[j]] eq 0 or h2.lrot[tag[j]] eq 1 or h2.lrot[tag[j]] eq 4 then tmpthick=2*tmpthick 
;      oplot,[mk_wl[tag[j]], mk_wl[tag[j]] ],[mky,mky_end],$ 
;        color=colorlist[k],thick=tmpthick
;    endfor
;    mk_wl=(ivelc[k]/3.e5+1.0)*hd.wl
;    if  tag_hd[0] ne -1 then begin
;        mky_end=mky-dl*0.16
;;        arrow, mk_wl[tag_hd],replicate(mky,n_elements(tag_hd)),$
;;              mk_wl[tag_hd],replicate(mky_end,n_elements(tag_hd)),$
;;              color=colorlist[k],/data,$
;;              hsize=!D.X_SIZE/64./3.0,thick=2.0,hthick=2.0,noclip=0
;    endif    
;  endfor
;  npos_min=(min(ivelc)/3.e5+1.0)*min(h2.wl[tag])
;  npos_max=(max(ivelc)/3.e5+1.0)*max(h2.wl[tag])
;  oplot,[npos_min,npos_max],[mky,mky],$
;      color=cgcolor('black'),thick=1.0
;  xyouts,npos_min-0.1, mky_label,h2label, $
;      ALIGNMENT=0.5,color=cgcolor('black'),$
;      NOCLIP=0,charsize=0.7,orie=90
;;  if  tag_hd[0] ne -1 then begin
;;      npos_min_hd=(min(ivelc)/3.e5+1.0)*min(hd.wl[tag_hd])
;;      oplot,[npos_min_hd,npos_min],[mky,mky],$
;;        color=cgcolor('black'),thick=1.0,linestyle=1      
;;  endif    
;endfor
;
;;
;
;
;;; for atomic lines, all lines turned on
;;atom_list=strtrim(atom_label,2)
;;atom_list=STRSPLIT(atom_list,' ',/ex)
;;atom_list=atom_list->toarray()
;;atom_list=atom_list[*,0]
;
;rows_atom=[ 'H', 'B', 'C', 'N', 'O', 'Ne', 'Mg', 'Si', 'S', 'Cl', 'Fe']
;reg_rows_atom=strjoin(rows_atom,'|')
;atom_use=replicate(0,n_elements(at.label))
;atom_use=STREGEX(at.label,reg_rows_atom)
;
;for i=0,n_elements(at.label)-1 do begin
;  if atom_use[i] gt -1 then begin
;    for k=0,n_elements(ivelc)-1 do begin
;      mk_wl=(ivelc[k]/3.e5+1.0)*at.wl[i]
;      mky=0.0
;      oplot,[mk_wl, mk_wl],[mky+dl*0.03,mky-dl*0.03], color=colorlist[k],thick=thick
;    endfor
;  endif
;endfor
;
;
;wv_atom=[ 1048.2199,$
;  1020.6989,$
;  1031.9261,$
;  1048.2199,$
;  1066.6599,$
;  1063.1764,$
;  1063.9718,$
;  1063.002,$
;  1144.9379,$
;  1121.9748,$
;  1143.2260,$
;  1125.4477,$
;  1152.818,$
;  1081.8748,$
;  1096.8769,$
;  1055.2617,$
;  1063.9718,$
;  1062.152,$
;  1112.0480,$
;  1127.0984,$
;  1133.665,$
;  1142.3656,$
;  1039.2304,$
;  1134.9803,$
;  1134.4149,$
;  1134.1653,$
;  948.6855,$
;  936.6295,$
;  976.4481,$
;  929.5168,$
;  950.8846,$
;  924.952,$
;  953.9699,$
;  953.6549,$
;  963.9903,$
;  953.4152,$
;  964.6256,$
;  965.0413,$
;  1037.0182,$
;  1036.3367,$
;  1073.769,$
;  1073.516]
;  for i=0,n_elements(wv_atom)-1 do begin
;      for k=0,n_elements(ivelc)-1 do begin
;        mk_wl=(ivelc[k]/3.e5+1.0)*wv_atom[i]
;        mky=0.0
;        oplot,[mk_wl, mk_wl],[mky+dl*0.03,mky-dl*0.03], color=colorlist[k],thick=thick
;      endfor
;  endfor

;
;; for instrument segment borders
;
;if not keyword_set(noseg) then begin
;lb=[987.4,1082.75,904.20,992.61,1086.82,1181.40]
;for i=0,n_elements(lb)-1 do begin
;  if i mod 2 eq 0 then vd=0.15
;  if i mod 2 eq 1 then vd=-0.15
;  
;  oplot,[lb[i],lb[i]],[yrange[0]+dl,yrange[1]-0.1],color=cgcolor('blue'),thick=4.0
;  oplot,[lb[i],lb[i]+vd],[yrange[0]+dl,yrange[0]+dl],color=cgcolor('blue'),thick=4.0
;  oplot,[lb[i],lb[i]+vd],[yrange[1]-dl,yrange[1]-dl],color=cgcolor('blue'),thick=4.0
;endfor
;endif


