#!/bin/bash

#-------------------------------------------------------------------------------
#哉亚 2022.4.21
#其他没什么区别就是比黎明的开服方便点
#参考脚本：go.sh  l.sh  z.sh  dstserver_20210321.sh
#代码支持：浅浅，23，迟迟，初撤，北柠，大大，小休，safe
#服务器支持：大大
#精神支持：鸽子窝全体小伙伴，小休，大大
#-------------------------------------------------------------------------------

gamesFile="./dontstarve_dedicated_server_nullrenderer_x64"
MyDediServers="$HOME/.klei/DoNotStarveTogether/MyDediServer"
dst_home=~/dst
dst_shell_home=$(pwd)
log_home="$dst_shell_home/dstgl_log.txt"
gamesPath=~/dst/bin64
game=$dst_home/mods/dedicated_server_mods_setup.lua
DST_HOME="${HOME}/dst"
ugc_directory="${DST_HOME}/ugc_mods"
dst_conf_basedir="${HOME}/.klei"
dst_conf_dirname="DoNotStarveTogether"
modlistpath="${HOME}/dst/mods"
modlistpath2="${HOME}/dst/ugc_mods"
#创建自己的库
data_dir="${HOME}/library"
mod_cfg_dir="${data_dir}/modconfigure"
parent_mod_dir="${ugc_directory}/content/322330"
Red_font_prefix="\033[31m"
Font_color_suffix="\033[0m"
dst_server_dir=$DST_HOME

dst_base_dir="${dst_conf_basedir}/${dst_conf_dirname}"
#创建DST的方法
info() {
  echo -e "${Info}" "$1"
}
tip() {
  echo -e "${Tip}" "$1"
}
error() {
  echo -e "${Error}" "$1"
}

# 屏幕输出
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Yellow_font_prefix="\033[33m"
Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Yellow_font_prefix}[提示]${Font_color_suffix}"

#日志
outputLog() {
  echo "$(date +%m-%d-%T) $1 $2 $3 $4 $5 $6 $7 $8" >>"$log_home" 2>&1
}
#设置默认
outputOptionsReset() {
  number=0
  #OutputLog "输出选项的编号以重置"
}
#间隔
outputInterval() {
  echo -e "\033[$1m============================================================\033[0m"
  outputLog "============================================================"
}
#选项
outputOptions6() {
  local num=()
  local optione=()
  optione[1]=$2
  optione[2]=$3
  optione[3]=$4
  optione[4]=$5
  optione[5]=$6
  optione[6]=$7
  local i
  for ((i = 0; i < ${#optione[@]}; i++)); do
    if [[ -z ${optione[i]} ]]; then
      optione[i]="退出"
      num[i]=0
    else
      ((number++))
      num[i]=$number
    fi
  done
  local output
  output=$(printf "===[%2d.%-2s] [%2d.%-2s] [%2d.%-2s] [%2d.%-2s] [%2d.%-2s] [%2d.%-2s]====\n" \
    "${num[1]}" ${optione[1]} "${num[2]}" ${optione[2]} "${num[3]}" ${optione[3]} "${num[4]}" ${optione[4]} "${num[5]}" ${optione[5]} "${num[6]}" ${optione[6]})
  echo -e "\033[$1m$output\033[0m"
  outputLog "$output"
}
outputOptions5() {
  local num
  local optione
  optione[1]=$2
  optione[2]=$3
  optione[3]=$4
  optione[4]=$5
  local i
  for ((i = 0; i < ${#optione[@]}; i++)); do
    if [[ -z ${optione[i]} ]]; then
      optione[i]="退出这菜单"
      num[i]=0
    else
      ((number++))
      num[i]=$number
    fi
  done
  local output
  output=$(printf "======[%2d.%-5s] [%2d.%-5s] [%2d.%-5s]=======\n" \
    "${num[1]}" ${optione[1]} "${num[2]}" ${optione[2]} "${num[3]}" ${optione[3]})
  echo -e "\033[$1m$output\033[0m"
  outputLog "$output"
}
outputOptions4() {
  local num=()
  local optione=()
  optione[1]=$2
  optione[2]=$3
  optione[3]=$4
  optione[4]=$5
  local i
  for ((i = 0; i < ${#optione[@]}; i++)); do
    if [[ -z ${optione[i]} ]]; then
      optione[i]="退出菜单"
      num[i]=0
    else
      ((number++))
      num[i]=$number
    fi
  done
  local output
  output=$(printf "===[%2d.%-4s] [%2d.%-4s] [%2d.%-4s] [%2d.%-4s]==\n" \
    "${num[1]}" ${optione[1]} "${num[2]}" ${optione[2]} "${num[3]}" ${optione[3]} "${num[4]}" ${optione[4]})
  echo -e "\033[$1m$output\033[0m"
  outputLog "$output"
}
outputOptions2() {
  local num=()
  local optione=()
  optione[1]=$2
  optione[2]=$3
  optione[3]=$4
  optione[4]=$5
  optione[4]=$5
  optione[5]=$6
  local i
  for ((i = 0; i < ${#optione[@]}; i++)); do
    if [[ -z ${optione[i]} ]]; then
      optione[i]="退出"
      num[i]=0
    else
      ((number++))
      num[i]=$number
    fi
  done
  local output
  output=$(printf "=====[%2d.%-2s] [%2d.%-2s] [%2d.%-2s] [%2d.%-2s] [%2d.%-2s]======\n" \
    "${num[1]}" ${optione[1]} "${num[2]}" ${optione[2]} "${num[3]}" ${optione[3]} "${num[4]}" ${optione[4]} "${num[5]}" ${optione[5]})
  echo -e "\033[$1m$output\033[0m"
  outputLog "$output"
}
#自检 [内容]
outputSelfTest() {
  echo -e "\033[36m[自检]:$1\033[0m"
  outputLog "[自检]:$1"
}
#提示 [颜色] [内容]
outputTips() {
  echo -e "\033[$1m[提示]:$2\033[0m"
  outputLog "[提示]:$2"
  return 1
}
#成功 [内容]
outputSuccess() {
  echo -e "\033[1;36m[成功]:$1\033[0m"
  outputLog "[成功]:$1"
}
#报错 [内容]
outputError() {
  if [[ $1 = "-e" ]]; then
    echo -e "\033[1;31m[警告]:未找到$2目录\033[0m"
    outputLog "[警告]:未找到$2目录"
  else
    echo -e "\033[1;31m[警告]:$1\033[0m"
    outputLog "[警告]:$1"
  fi
}
#提示任意界面退出
outputReturn() {
  outputTips 33 任意界面都可输入0返回上一级菜单
}

#创建世界函数
Addshard() {
  while (true); do
  clear
outputOptionsReset
outputTips 33 请选择地面/洞穴/地面+洞穴世界,熔炉/挂机/暴食房
outputTips 33 输入0添加完成
outputOptions5 36 地面 洞穴 熔炉 挂机 暴食
#    echo -e "\e[92m请选择要添加的世界：1.地面世界  2.洞穴世界  3.正常世界  0.添加完成\n          快捷设置：4.熔炉MOD[Forged forge]房  5.熔炉MOD[ReForged]房\n                    6.挂机MOD房选我  7.暴食MOD房选我\n\e[0m\c"
    read shardop
    case "${shardop}" in
    1)
      Addforest
      ;;
    2)
      Addcaves
      ;;
    3)
      Reforgedworld
      break
      ;;
    0)
      encodes
      break
      ;;
    4)
      AOGworld
      break
      ;;
    5)
      Gorgeworld
      break
      ;;
    *)
      error "输入有误，请输入[1-5]！！！"
      ;;
    esac
  done
Main
}
Shardconfig() {
  tip "只能有一个主世界！！！熔炉MOD房、挂机MOD房和暴食MOD房只能选主世界！！！"
  info "已创建${shardtype}[$sharddir]，这是一个：1. 主世界   2. 附从世界？ "
  read ismaster
  if [ "${ismaster}" -eq 1 ]; then
    shardmaster="true"
    shardid=1
  else
    shardmaster="false"
    # 非主世界采用随机数，防止冲突
    shardid=$RANDOM
  fi
  encode="true"
#  tip "如需要玩家存档对应文件夹为玩家KleiID,以下请选否"
#  info "编码玩家存档路径：1. 是   2. 否？ "
#  read isencode
#  if [ "${isencode}" -eq 2 ]; then
#    encode="false"
#  fi
  cat >"${dst_base_dir}/MyDediServer/$sharddir/server.ini" <<-EOF
[NETWORK]
server_port = $((10997 + $idnum))


[SHARD]
is_master = $shardmaster
name = ${shardname}${idnum}
id = $shardid


[ACCOUNT]
encode_user_path = $encode


[STEAM]
master_server_port = $((27016 + $idnum))
authentication_port = $((8766 + $idnum))
EOF
}
Getidnum() {
  idnum=$(($(ls -l "${dst_base_dir}/MyDediServer" | grep ^d | awk '{print $9}' | grep -c ^) + 1))
}
Createsharddir() {
  sharddir="${shardname}${idnum}"
  mkdir -p "${dst_base_dir}/MyDediServer/$sharddir"
}
Addcaves() {
  shardtype="洞穴世界"
  shardname="Caves"
  Getidnum
  Createsharddir
  Shardconfig
  Set_world
}
Addforest() {
  shardtype="地面世界"
  shardname="Master"
  Getidnum
  Createsharddir
  Shardconfig
  Set_world
}
Gorgeworld() {
  shardtype="暴食MOD房"
  shardname="Master"
  Wmodid="1918927570"
  Wconfigfile="quagmire.lua"
  Getidnum
  Createsharddir
  Shardconfig
  Set_world
}
Forgeworld() {
  shardtype="熔炉MOD房[Forged Forge]"
  shardname="Master"
  Wmodid="1531169447"
  Wconfigfile="lavaarena.lua"
  Getidnum
  Createsharddir
  Shardconfig
  Set_world
}
Reforgedworld() {
  shardtype="熔炉MOD房[ReForged]"
  shardname="Master"
  Wmodid="1938752683"
  Wconfigfile="lavaarena1.lua"
  Getidnum
  Createsharddir
  Shardconfig
  Set_world
}
AOGworld() {
  shardtype="挂机MOD房"
  shardname="Master"
  Wmodid="1981709850"
  Wconfigfile="aog.lua"
  Getidnum
  Createsharddir
  Shardconfig
  Set_world
}
Set_world_config() {
  while (true); do
    #clear
    index=1
    linenum=1
    list=(WORLDSETTINGS_global WORLDSETTINGS_survivors WORLDSETTINGS_misc WORLDSETTINGS_resources WORLDSETTINGS_animals WORLDSETTINGS_monsters WORLDSETTINGS_giants WORLDGEN_global WORLDGEN_misc WORLDGEN_resources WORLDGEN_animals WORLDGEN_monsters)
    liststr=(
      ================================世界选项-全局================================
      ================================世界选项-冒险家==============================
      ================================世界选项-世界================================
      ================================世界选项-资源再生============================
      ================================世界选项-生物================================
      ================================世界选项-敌对生物============================
      ================================世界选项-巨兽================================
      ================================世界生成-全局================================
      ================================世界生成-世界================================
      ================================世界生成-资源================================
      ================================世界生成-生物及刷新店=========================
      ================================世界生成-敌对生物及刷新店=====================
    )
    for ((j = 0; j < ${#list[*]}; j++)); do
      echo -e "\n\e[92m${liststr[$j]}\e[0m"
      cat "${configure_file}" | while read line; do
        ss=(${line})
        if [ "${#ss[@]}" -gt 4 ]; then
          if [ "${index}" -gt 3 ]; then
            printf "\n"
            index=1
          fi
          for ((i = 4; i < ${#ss[*]}; i++)); do
            if [ "${ss[$i]}" == "${ss[1]}" ]; then
              value=${ss[$i + 1]}
            fi
          done
          if [ "${list[$j]}" == "${ss[2]}" ]; then
            if [ ${linenum} -lt 10 ]; then
              printf "%-21s\t" "[ ${linenum}]${ss[3]}: ${value}"
            else
              printf "%-21s\t" "[${linenum}]${ss[3]}: ${value}"
            fi
            index=$((${index} + 1))
          fi
        fi
        linenum=$((${linenum} + 1))
      done
    done
    printf "\n"
    unset cmd
    while (true); do
      if [[ "${cmd}" == "" ]]; then
        echo -e "\e[92m请选择你要更改的选项(修改完毕输入数字 0 确认修改并退出)： \e[0m\c"
        read cmd
      else
        break
      fi
    done
    case "${cmd}" in
    0)
      info "更改已保存！"
      break
      ;;
    *)
      changelist=($(sed -n "${cmd}p" "${configure_file}"))
      echo -e "\e[92m请选择${changelist[3]}： \e[0m\c"
      index=1
      for ((i = 4; i < ${#changelist[*]}; i = $i + 2)); do
        echo -e "\e[92m${index}.${changelist[$(($i + 1))]}   \e[0m\c"
        index=$((${index} + 1))
      done
      echo -e "\e[92m: \e[0m\c"
      read changelistindex
      listnum=$((${changelistindex} - 1))*2
      changelist[1]=${changelist[$(($listnum + 4))]}
      changestr="${changelist[@]}"
      sed -i "${cmd}c ${changestr}" "${configure_file}"
      ;;
    esac
  done
}
Set_world() {
  if [[ "${shardtype}" == "熔炉MOD房[Forged Forge]" ]]; then
    cat "${data_dir}/${Wconfigfile}" >"${dst_base_dir}/MyDediServer/${sharddir}/leveldataoverride.lua"
    info "${shardtype}世界配置已写入！"
    info "正在检查${shardtype}MOD是否已下载安装 。。。"
    if [ -f "${HOME}/dst/mods/workshop-${Wmodid}/modinfo.lua" ]; then
      info "${shardtype}MOD已安装 。。。"
    else
      tip "${shardtype}MOD未安装 。。。即将下载 。。。"
      echo "ServerModSetup(\"${Wmodid}\")" >"${HOME}/dst/mods/dedicated_server_mods_setup.lua"
      modup
    fi
    if [ -f "${HOME}/dst/mods/workshop-${Wmodid}/modinfo.lua" ]; then
      Default_mod
      modid=${Wmodid}
      Addmodfunc
      info "${shardtype}MOD已启用 。。。"
    else
      tip "${shardtype}MOD启用失败，请自行检查原因或反馈 。。。"
    fi
  elif [[ "${shardtype}" == "暴食MOD房" || "${shardtype}" == "熔炉MOD房[ReForged]" || "${shardtype}" == "挂机MOD房" ]]; then
    cat "${data_dir}/${Wconfigfile}" >"${dst_base_dir}/MyDediServer/${sharddir}/leveldataoverride.lua"
    info "${shardtype}世界配置已写入！"
    info "正在检查${shardtype}MOD是否已下载安装 。。。"
    if [ -f "${parent_mod_dir}/${Wmodid}/modinfo.lua" ]; then
      info "${shardtype}MOD已安装 。。。"
    else
      tip "${shardtype}MOD未安装 。。。即将下载 。。。"
      echo "ServerModSetup(\"${Wmodid}\")" >"${HOME}/dst/mods/dedicated_server_mods_setup.lua"
      modup
    fi
    if [ -f "${parent_mod_dir}/${Wmodid}/modinfo.lua" ]; then
      Default_mod
      modid=${Wmodid}
      Addmodfunc
      info "${shardtype}MOD已启用 。。。"
    else
      tip "${shardtype}MOD启用失败，请自行检查原因或反馈 。。。"
    fi
  else
    info "是否修改${shardtype}[${sharddir}]配置？：1.是 2.否（默认为上次配置）"
    read wc
    configure_file="${data_dir}/${shardname}leveldata.txt"
    data_file="${dst_base_dir}/MyDediServer/${sharddir}/leveldataoverride.lua"
    if [ "${wc}" -ne 2 ]; then
      Set_world_config
    fi
    Write_in ${shardname}
    check_cluster_file "leveldataoverride.lua"
    Default_mod
  fi
}
Write_in() {
  data_num=$(grep -n "^" "${configure_file}" | tail -n 1 | cut -d : -f1)
  cat "${data_dir}/${1}start.lua" >"${data_file}"
  index=1
  cat "${configure_file}" | while read line; do
    ss=(${line})
    if [ "${index}" -lt "${data_num}" ]; then
      char=","
    else
      char=""
    fi
    index=$((${index} + 1))
    if [[ "${ss[1]}" == "highlyrandom" ]]; then
      str="${ss[0]}=\"highly random\"${char}"
    else
      str="[\"${ss[0]}\"]=\"${ss[1]}\"${char}"
    fi
    echo "    ${str}" >>"${data_file}"
  done
  cat "${data_dir}/${1}end.lua" >>"${data_file}"
}
Default_mod() {
	cd $MyDediServers
		allsave=$(ls -l  | grep ^d | awk '{print $9}')
    for save in ${allsave}; do
    if [ ! -f "${dst_base_dir}/MyDediServer/${save}/modoverrides.lua" ]; then
      echo 'return {
}' >"${dst_base_dir}/MyDediServer/${save}/modoverrides.lua"
    fi
  done
}
Addmodfunc() {
  Truemodid
  fuc="createmodcfg"
  MOD_conf
  Write_mod_cfg
  Addmodtoshard
  Removelastcomma
  check_cluster_file "modoverrides.lua"
}

Truemodid() {
  if [ ${modid} -lt 10000 ]; then
    moddir=$(sed -n ${modid}p "${data_dir}/modconflist.lua" | cut -d ':' -f3)
    # if [[ ! -d ${dst_server_dir}/mods/workshop-${modid} ]]; then
    #   moddir=$(echo ${modid} | tr -cd '[0-9]')
    # fi
    if [[ $(echo ${moddir} | grep -c '^workshop') -gt 0 ]]
    then
      moddir=$(echo ${moddir} | cut -d '-' -f2)
    fi
  else
    moddir=${modid}
  fi
  # echo $moddir
}
Getinputlist() {
  inputarray=()
  for i in $1; do
    if echo $i | grep '-' >/dev/null; then
      m=$(echo $i | cut -d '-' -f1)
      n=$(echo $i | cut -d '-' -f2)
      for j in $(seq $m $n); do
        inputarray[${#inputarray[@]} + 1]=$j
      done
    else
      inputarray[${#inputarray[@]} + 1]=$i
    fi
  done
}
update_mod_cfg() {
  if [[ -f "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" ]]; then
    cat > "${data_dir}/modinfo.lua" <<-EOF
fuc = "createmodcfg"
modid = "${moddir}"
EOF
    cat "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" >> "${data_dir}/modinfo.lua"
    if [[ -f "${dst_server_dir}/mods/workshop-${moddir}/modinfo_chs.lua" ]]; then
      cat "${dst_server_dir}/mods/workshop-${moddir}/modinfo_chs.lua" >> "${data_dir}/modinfo.lua"
    fi
    cd "${data_dir}"
    lua modconf.lua >/dev/null 2>&1
    if ! lua modconf.lua >/dev/null 2>&1; then
        cat > "${data_dir}/modinfo.lua" <<-EOF
fuc = "createmodcfg"
modid = "${moddir}"
EOF
    cat "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" >> "${data_dir}/modinfo.lua"

    lua modconf.lua >/dev/null 2>&1
    fi
    cd "${DST_HOME}"
  elif [[ -f "$parent_mod_dir/${moddir}/modinfo.lua" ]]; then
    cat >"${data_dir}/modinfo.lua" <<-EOF
fuc = "createmodcfg"
modid = "${moddir}"
EOF
    cat "$parent_mod_dir/${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
    if [[ -f "$parent_mod_dir/${moddir}/modinfo_chs.lua" ]]; then
      cat "$parent_mod_dir/${moddir}/modinfo_chs.lua" >>"${data_dir}/modinfo.lua"
    fi
    cd "${data_dir}"
    lua modconf.lua >/dev/null 2>&1
    if [ $? -gt 1 ]; then
        cat > "${data_dir}/modinfo.lua" <<-EOF
fuc = "createmodcfg"
modid = "${moddir}"
EOF
    cat "$parent_mod_dir/${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
    lua modconf.lua >/dev/null 2>&1
    fi
    cd "${DST_HOME}"
  else
    tip "请先安装并启用MOD！"
    break
  fi
}
MOD_conf() {
  if [[ "${fuc}" == "createmodcfg" ]]; then
    if [[ -f "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" ]]; then
      cat "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
    elif [[ -f "$parent_mod_dir/${moddir}/modinfo.lua" ]]; then
      cat "$parent_mod_dir/${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
    else
      echo "ServerModSetup(\"${moddir}\")" >"${dst_server_dir}/mods/dedicated_server_mods_setup.lua"
      # 当输入多个MODID时，在第一次下载时全部添加下载
      for exmodid in ${inputarray[@]}; do
        if [ $exmodid -gt 100000 ]; then
          echo "ServerModSetup(\"$exmodid\")" >>"${dst_server_dir}/mods/dedicated_server_mods_setup.lua"
        fi
      done
      modup
    fi
    if [[ -f "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" ]]; then
      if [ ! -f "${mod_cfg_dir}/${moddir}.cfg" ]; then
        update_mod_cfg
      fi
    elif [[ -f "$parent_mod_dir/${moddir}/modinfo.lua" ]]; then
      if [ ! -f "${mod_cfg_dir}/${moddir}.cfg" ]; then
        update_mod_cfg
      fi
    else
      error "MOD安装失败，无法继续请上传MOD或重试！"
      exit 0
    fi
  else
    cat >"${data_dir}/modinfo.lua" <<-EOF
fuc = "${fuc}"
modid = "${moddir}"
used = "${used}"
EOF
    if [[ -f "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" ]]; then
      cat "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
    else
      moddir=$(echo "${moddir}" | tr -cd '[0-9]')
      if [[ -f "$parent_mod_dir/${moddir}/modinfo.lua" ]]; then
        cat "$parent_mod_dir/${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
      else
        echo "name = \"MOD文件已损坏\"" >>"${data_dir}/modinfo.lua"
      fi
    fi
    cd ${data_dir}
    lua modconf.lua >/dev/null 2>&1
    cd ${DST_HOME}
  fi
}
Write_mod_cfg() {
  Delmodfromshard >/dev/null 2>&1
  rm "${data_dir}/modconfwrite.lua" >/dev/null 2>&1
  touch "${data_dir}/modconfwrite.lua"
  workshopmoddir=${moddir}
  if [ $(echo $moddir | grep -c "workshop") -eq 0 ]; then
    workshopmoddir="workshop-"${moddir}
  fi
  if [ -f "${mod_cfg_dir}/${moddir}.cfg" ]; then
    c_line=$(grep "^" -n "${mod_cfg_dir}/${moddir}.cfg" | tail -n 1 | cut -d : -f1)
    if [[ $c_line -le 3 ]]; then
      echo "  [\"$workshopmoddir\"]={ [\"enabled\"]=true }," >>"${data_dir}/modconfwrite.lua"
    else
      echo "  [\"$workshopmoddir\"]={" >>"${data_dir}/modconfwrite.lua"
      echo "    configuration_options={" >>"${data_dir}/modconfwrite.lua"
      # cindex=4
      cat "${mod_cfg_dir}/${moddir}.cfg" | grep -v "mod-configureable" | grep -v "mod-version" | grep -v "mod-name" | while read lc; do
        lcstr=($lc)
        cfgname=$(echo "${lcstr[0]}" | sed 's/#/ /g')
        if [[ "${lcstr[2]}" != "table" ]]; then
          if [[ "${lcstr[2]}" == "number" ]]; then
            echo -e "      [\"$cfgname\"]=${lcstr[1]}," >>"${data_dir}/modconfwrite.lua"
          elif [[ "${lcstr[2]}" == "string" ]]; then
            echo -e "      [\"$cfgname\"]=\"${lcstr[1]}\"," >>"${data_dir}/modconfwrite.lua"
          elif [[ "${lcstr[2]}" == "boolean" ]]; then
            echo -e "      [\"$cfgname\"]=${lcstr[1]}," >>"${data_dir}/modconfwrite.lua"
          fi
        fi
      done
      echo "    }," >>"${data_dir}/modconfwrite.lua"
      echo "    [\"enabled\"]=true" >>"${data_dir}/modconfwrite.lua"
      echo "  }," >>"${data_dir}/modconfwrite.lua"
    fi
  else
    echo "  [\"$workshopmoddir\"]={ [\"enabled\"]=true }," >>"${data_dir}/modconfwrite.lua"
  fi
  Addmodtoshard >/dev/null 2>&1
}
Delmodfromshard() {
cd $MyDediServers
allsave=$(ls -l  | grep ^d | awk '{print $9}')
  for shard in ${allsave}; do
    if [ -f "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" ]; then
      if [ $(grep "${moddir}" -c "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua") -gt 0 ]; then
        grep -n "^  \[" "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" >"${data_dir}/modidlist.txt"
        lastmodlinenum=$(cat "${data_dir}/modidlist.txt" | tail -n 1 | cut -d ":" -f1)
        up=$(grep "${moddir}" "${data_dir}/modidlist.txt" | cut -d ":" -f1)
        if [ "${lastmodlinenum}" -eq "${up}" ]; then
          down=$(grep "^" -n "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" | tail -n 1 | cut -d ":" -f1)
        else
          down=$(grep -A 1 "${moddir}" "${data_dir}/modidlist.txt" | tail -1 | cut -d ":" -f1)
        fi
        upnum=${up}
        downnum=$((${down} - 1))
        sed -i "${upnum},${downnum}d" "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua"
        info "${shard}世界该Mod(${moddir})已停用！"
      else
        info "${shard}世界该Mod(${moddir})未启用！"
      fi
    else
      tip "${shard} MOD配置文件未由脚本初始化，无法操作！如你已自行配置请忽略本提示！"
    fi
  done
}
Addmodtoshard() {
	cd $MyDediServers
		shardarray=$(ls -l  | grep ^d | awk '{print $9}')
  for shard in ${shardarray}; do
    if [ -f "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" ]; then
      if [ $(grep "${moddir}" -c "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua") -gt 0 ]; then
        info "${shard}世界该Mod(${moddir})已添加"
      else
        sed -i '1d' "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua"
        cat "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" >"${data_dir}/modconftemp.txt"
        echo "return {" >"${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua"
        cat "${data_dir}/modconfwrite.lua" >>"${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua"
        cat "${data_dir}/modconftemp.txt" >>"${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua"
        info "${shard}世界Mod(${moddir})添加完成"
      fi
    else
      tip "${shard} MOD配置文件未由脚本初始化，无法操作！如你已自行配置请忽略本提示！"
    fi
  done
}
# 保证最后一个MOD配置结尾不含逗号
Removelastcomma() {
  for shard in ${shardarray}; do
    if [ -f "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" ]; then
      checklinenum=$(grep "^" -n "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" | tail -n 2 | head -n 1 | cut -d ":" -f1)
      sed -i "${checklinenum}s/,//g" "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua"
    fi
  done
}
#删除模组
Delmod() {
  info "请从以上列表选择你要停用的MOD${Red_font_prefix}[编号]${Font_color_suffix}[可多选，如输入\"1 2 4-6\"],完毕请输数字 0 ！"
  while (true); do
    read modid
    if [[ "${modid}" == "0" ]]; then
      info "MOD删除完毕！"
      break
    else
      Getinputlist "$modid"
      for modid in ${inputarray[@]}; do
        Truemodid
        Delmodfromshard
      done
    fi
  done
  check_cluster_file "modoverrides.lua"
}
Get_installed_mod_version() {
  if [ -f "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" ]; then
    echo "fuc=\"getver\"" >"${data_dir}/modinfo.lua"
    cat "${dst_server_dir}/mods/workshop-${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
    cd "${data_dir}"
    result=$(lua modconf.lua)
    cd ${DST_HOME}
  elif [ -f  "$parent_mod_dir/${moddir}/modinfo.lua" ]
  then
    echo "fuc=\"getver\"" >"${data_dir}/modinfo.lua"
    cat "$parent_mod_dir/${moddir}/modinfo.lua" >>"${data_dir}/modinfo.lua"
    cd "${data_dir}"
    result=$(lua modconf.lua)
    cd ${DST_HOME}
  else
    result="uninstalled"
  fi
}
Get_data_from_file() {
  if [ -f "$1" ]; then
    result=$(grep "^$2" "$1" | head -n 1 | cut -d " " -f3)
  fi
}
# 传入moddir
Show_mod_cfg() {
  if [ -f "${mod_cfg_dir}/${moddir}.cfg" ]; then
    Get_installed_mod_version
    n_ver=$result
    Get_data_from_file "${mod_cfg_dir}/${moddir}.cfg" mod-version
    c_ver=$result
    if [[ "$n_ver" != "$c_ver" ]]; then
      update_mod_cfg
    fi
  else
    update_mod_cfg
  fi
  Get_data_from_file "${mod_cfg_dir}/${moddir}.cfg" "mod-configureable"
  c_able=$result
  c_line=$(grep "^" -n "${mod_cfg_dir}/${moddir}.cfg" | tail -n 1 | cut -d : -f1)
  if [[ "$c_able" == "true" && "$c_line" -gt 3 ]]; then
    Get_data_from_file "${mod_cfg_dir}/${moddir}.cfg" "mod-version"
    c_ver=$result
    Get_data_from_file "${mod_cfg_dir}/${moddir}.cfg" "mod-name"
    c_name=$(echo $result | sed 's/#/ /g')
    while (true); do
      #clear
      echo -e "\e[92m【修改MOD：$c_name配置】[$c_ver]\e[0m"
      index=1
      cat "${mod_cfg_dir}/${moddir}.cfg" | grep -v "mod-configureable" | grep -v "mod-version" | grep -v "mod-name" | while read line; do
        ss=(${line})
        if [ "${ss[2]}" == "table" ]; then
          value=${ss[1]}
        else
          for ((i = 5; i < ${#ss[*]}; i = $i + 3)); do
            if [ "${ss[$i]}" == "${ss[1]}" ]; then
              value=${ss[$i + 1]}
            fi
          done
        fi
        if [[ "$value" == "不明项勿修改" ]]; then
          value=${ss[1]}
        fi
        value=$(echo "$value" | sed 's/#/ /g')
        label=$(echo "${ss[3]}" | sed 's/#/ /g')
        hover=$(echo "${ss[4]}" | sed 's/#/ /g')
        if [[ "$label" == "" || "$label" == "nolabel" ]]; then
          label=$(echo "${ss[0]}" | sed 's/#/ /g')
          hover="${Red_font_prefix}该项作用不明，请勿轻易修改否则可能出错。详情请查看modinfo.lua文件。${Font_color_suffix}"
        fi
        if [ "${index}" -lt 10 ]; then
          echo -e "\e[33m[ ${index}] $label：${Red_font_prefix}${value}${Font_color_suffix}\n     简介==>$hover\e[0m"
        else
          echo -e "\e[33m[${index}] $label：${Red_font_prefix}${value}${Font_color_suffix}\n     简介==>$hover\e[0m"
        fi
        index=$(($index + 1))
      done
      echo -e "\e[92m===============================================\e[0m"
      unset cmd
      while (true); do
        if [[ "${cmd}" == "" ]]; then
          echo -e "\e[92m请选择你要更改的选项(修改完毕输入数字 0 确认修改并退出)：\e[0m\c"
          read cmd
        else
          break
        fi
      done
      case "${cmd}" in
      0)
        info "更改已保存！"
        break
        ;;
      *)
        cmd=$(($cmd + 3))
        changelist=($(sed -n "${cmd}p" "${mod_cfg_dir}/${moddir}.cfg"))
        label=$(echo "${changelist[3]}" | sed 's/#/ /g')
        if [[ "$label" == "" || "$label" == "nolabel" ]]; then
          label=$(echo "${changelist[0]}" | sed 's/#/ /g')
        fi
        if [ "${changelist[2]}" = "table" ]; then
          tip "${Red_font_prefix}此项为表数据，请直接修改modinfo.lua文件${Font_color_suffix}"
        else
          echo -e "\e[92m请选择$label： \e[0m"
          index=1
          for ((i = 5; i < ${#changelist[*]}; i = $i + 3)); do
            description=$(echo "${changelist[$(($i + 1))]}" | sed 's/#/ /g')
            hover=$(echo "${changelist[$(($i + 2))]}" | sed 's/#/ /g')
            printf "%-30s" "${index}.$description"
            echo -e "\e[92m简介==>$hover\e[0m"
            index=$((${index} + 1))
          done
          echo -e "\e[92m: \e[0m\c"
          read changelistindex
          listnum=$((${changelistindex} - 1))*3
          changelist[1]=${changelist[$(($listnum + 5))]}
        fi
        changestr="${changelist[@]}"
        sed -i "${cmd}c ${changestr}" "${mod_cfg_dir}/${moddir}.cfg"
        ;;
      esac
    done
  fi
}
#配置文件
Mod_Cfg() {
  while (true); do
    echo -e "\e[92m【存档已启用的MOD配置修改===============\e[0m"
    flag=true
    Listusedmod
    if [[ $flag == "true" ]]
    then
      info "请从以上列表选择你要配置的MOD${Red_font_prefix}[编号]${Font_color_suffix},完毕请输数字 0 ！"
      read modid
      if [[ "${modid}" == "0" ]]; then
        info "MOD配置完毕！"
        break
      else
        Truemodid
        Show_mod_cfg
        Write_mod_cfg
      fi
    else
      break
    fi
  done
  check_cluster_file "modoverrides.lua"
}
check_cluster_file(){
    file=${dst_base_dir}/MyDediServer/${shard}/$1
    # luac $file
    if [[ $? -ne 0 ]]
    then
      tip "$file 文件存在问题！请自行检查"
    fi
}
function modup()
{
	echo -e "\033[36m开始更新模组 \033[0m"
	cd $MyDediServers
		allsave=$(ls -l  | grep ^d | awk '{print $9}')
		for save in ${allsave}; do
		cd $HOME
		test=$(cat .klei/DoNotStarveTogether/MyDediServer/$save/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
		array=($test)
		echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
		for((i=0;i<${#array[@]};i++))
			do
		#	echo ${array[$i]}
			if cat "$game" | grep "ServerModSetup("\"${array[$i]}\"")"
			then
			echo "此模组已下载"
			else
			echo "没有这个模组正在写入"
			echo "ServerModSetup("\"${array[$i]}\"")" >> "$game"
			fi
		done
	done
  sudo rm -rf /$HOME/.klei/DoNotStarveTogether/Download/Master1/server_log.txt
	cd "$gamesPath"
	screen -S "更新" "$gamesFile" -only_update_server_mods -ugc_directory ${ugc_directory} -persistent_storage_root ${dst_conf_basedir} -conf_dir ${dst_conf_dirname} -cluster Download -shard Master1
#  while :; do
#    cd $HOME
#    logs=$(cat ".klei/DoNotStarveTogether/Download/Master1/server_log.txt")
#    if cat .klei/DoNotStarveTogether/Download/Master1/server_log.txt | grep "FinishDownloadingServerMods Complete!"; then
#      clear
#      echo -e "\033[33m 模组更新完毕\033[0m"
#      break
#    else
#      echo -e "\033[33m $logs\033[0m"
#      echo -e "\033[96m 如果卡在页面太久可以尝试按下ctrl+c强制退出重新更新\033[0m"
#      sleep 3
#    fi
#  done
  echo -e "\033[33m 正在检测是否有未下载/更新成功的模组\033[0m"
  if cat .klei/DoNotStarveTogether/Download/Master1/server_log.txt | grep "OnDownloadPublishedFile" >/dev/null 2>&1; then
    echo -e "\033[33m检测到有模组为下载/更新成功再次更新\033[0m"
    modup
  elif cat .klei/DoNotStarveTogether/Download/Master1/server_log.txt | grep "DownloadPublishedFile" >/dev/null 2>&1; then
    echo -e "\033[33m检测到有模组为下载/更新成功再次更新\033[0m"
    modup
  fi
}
Initfiles() {
  if [[ ! -d $data_dir ]];then
    mkdir -p $data_dir
  fi
  if [[ ! -d $mod_cfg_dir ]];then
    mkdir -p $mod_cfg_dir
  fi
  cat >$data_dir/aog.lua <<-EOF
return {
  desc="别傻了，还是充钱来的实在！！！",
  hideminimap=false,
  id="Auto_Open_Gift",
  location="forest",
  max_playlist_position=9,
  min_playlist_position=0,
  name="偷渡欧洲宝地--由哉亚创建!",
  numrandom_set_pieces=0,
  ordered_story_setpieces={  },
  override_level_string=false,
  ["overrides"]={
    ["alternatehunt"]="never",
    ["angrybees"]="never",
    ["antliontribute"]="never",
    ["autumn"]="never",
    ["bearger"]="never",
    ["beefalo"]="never",
    ["beefaloheat"]="never",
    ["bees"]="never",
    ["berrybush"]="never",
    ["birds"]="never",
    ["boons"]="never",
    ["branching"]="never",
    ["butterfly"]="never",
    ["buzzard"]="never",
    ["cactus"]="never",
    ["carrot"]="never",
    ["catcoon"]="never",
    ["chess"]="never",
    ["day"]="onlyday",
    ["deciduousmonster"]="never",
    ["deerclops"]="never",
    ["disease_delay"]="none",
    ["dragonfly"]="never",
    ["flint"]="never",
    ["flowers"]="never",
    ["frograin"]="never",
    ["goosemoose"]="never",
    ["grass"]="never",
    ["has_ocean"]=true,
    ["houndmound"]="never",
    ["hounds"]="never",
    ["hunt"]="never",
    ["keep_disconnected_tiles"]=true,
    ["krampus"]="never",
    ["layout_mode"]="LinkNodesByKeys",
    ["liefs"]="never",
    ["lightning"]="never",
    ["lightninggoat"]="never",
    ["loop"]="never",
    ["lureplants"]="never",
    ["marshbush"]="never",
    ["merm"]="never",
    ["meteorshowers"]="never",
    ["meteorspawner"]="never",
    ["moles"]="never",
    ["mushroom"]="never",
    ["no_joining_islands"]=true,
    ["no_wormholes_to_disconnected_tiles"]=true,
    ["penguins"]="never",
    ["perd"]="never",
    ["petrification"]="none",
    ["pigs"]="never",
    ["ponds"]="never",
    ["prefabswaps_start"]="classic",
    ["rabbits"]="never",
    ["reeds"]="never",
    ["regrowth"]="veryslow",
    ["roads"]="never",
    ["rock"]="never",
    ["rock_ice"]="never",
    ["sapling"]="never",
    ["season_start"]="autumn",
    ["specialevent"]="auto",
    ["spiders"]="never",
    ["spring"]="noseason",
    ["start_location"]="default",
    ["summer"]="noseason",
    ["tallbirds"]="never",
    ["task_set"]="Auto_Open_Gift",
    ["tentacles"]="never",
    ["touchstone"]="never",
    ["trees"]="never",
    ["tumbleweed"]="never",
    ["walrus"]="never",
    ["weather"]="never",
    ["wildfires"]="never",
    ["winter"]="noseason",
    ["world_size"]="small",
    ["wormhole_prefab"]="wormhole"
  },
  ["random_set_pieces"]={},
  ["required_prefabs"]={ "multiplayer_portal" },
  ["substitutes"]={},
  ["version"]=4
}
EOF

  cat >$data_dir/Cavesend.lua <<-EOF
  },
  required_prefabs={ "multiplayer_portal" },
  ["settings_desc"]="探查洞穴…… 一起！",
  ["settings_id"]="DST_CAVE",
  ["settings_name"]="洞穴",
  ["substitutes"]={  },
  ["version"]=4,
  ["worldgen_desc"]="探查洞穴…… 一起！",
  ["worldgen_id"]="DST_CAVE",
  ["worldgen_name"]="洞穴"
}
EOF

  cat >$data_dir/Cavesstart.lua <<-EOF
return {
  background_node_range={ 0, 1 },
  desc="由哉亚创建!",
  hideminimap=false,
  id="DST_CAVE",
  location="cave",
  max_playlist_position=999,
  min_playlist_position=0,
  name="洞穴探险--由哉亚创建!",
  numrandom_set_pieces=0,
  override_level_string=false,
  overrides={
EOF

  cat >$data_dir/Cavesleveldata.txt <<-EOF
branching default WORLDGEN_misc 分支 never 从不 least 最少 default 默认 most 最多 random 随机
touchstone default WORLDGEN_misc 试金石 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
world_size default WORLDGEN_misc 世界大小 small 小 medium 中 default 大 huge 巨大
prefabswaps_start default WORLDGEN_misc 开始资源多样化 classic 经典 default 默认 highlyrandom 非常随机
loop default WORLDGEN_misc 环形 never 从不 default 默认 always 总是
boons default WORLDGEN_misc 失败的冒险家 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
cavelight default WORLDGEN_misc 洞穴光照 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
start_location default WORLDGEN_misc 出生点 lavaarena 默认 plus 额外资源 darkness 黑暗 quagmire_startlocation 默认 caves 洞穴 default 默认
task_set default WORLDGEN_misc 生物群落 default 联机版 cave_default 地下 quagmire_taskset 暴食 classic 经典 lavaarena_taskset 熔炉
season_start default WORLDGEN_global 起始季节 default 秋 winter 冬 spring 春 summer 夏 autumn|spring 春或秋 winter|summer 冬季或夏季 autumn|winter|spring|summer 随机
slurper default WORLDGEN_animals 缀食者 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
monkey default WORLDGEN_animals 穴居猴桶 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
rocky default WORLDGEN_animals 石虾 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
bunnymen default WORLDGEN_animals 兔屋 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
slurtles default WORLDGEN_animals 蛞蝓龟窝 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
fissure default WORLDGEN_monsters 梦魇裂隙 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
spiders default WORLDGEN_monsters 蜘蛛巢 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
tentacles default WORLDGEN_monsters 触手 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
chess default WORLDGEN_monsters 发条装置 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
worms default WORLDGEN_monsters 洞穴蠕虫 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
cave_spiders default WORLDGEN_monsters 蛛网岩 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
bats default WORLDGEN_monsters 蝙蝠 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
grass default WORLDGEN_resources 草 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
rock default WORLDGEN_resources 巨石 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
mushroom default WORLDGEN_resources 蘑菇 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
cave_ponds default WORLDGEN_resources 池塘 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
sapling default WORLDGEN_resources 树苗 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
berrybush default WORLDGEN_resources 浆果丛 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
trees default WORLDGEN_resources 树（所有） never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
reeds default WORLDGEN_resources 芦苇 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
flint default WORLDGEN_resources 燧石 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
fern default WORLDGEN_resources 洞穴蕨类 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
flower_cave default WORLDGEN_resources 荧光花 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
mushtree default WORLDGEN_resources 蘑菇树 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
wormlights default WORLDGEN_resources 发光浆果 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
marshbush default WORLDGEN_resources 尖灌木 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
lichen default WORLDGEN_resources 苔藓 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
banana default WORLDGEN_resources 洞穴香蕉 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
spiderqueen default WORLDSETTINGS_giants 蜘蛛女王 never 无 rare 很少 default 默认 often 较多 always 大量
liefs default WORLDSETTINGS_giants 树精守卫 never 无 rare 很少 default 默认 often 较多 always 大量
toadstool default WORLDSETTINGS_giants 毒菌蟾蜍 never 无 rare 很少 default 默认 often 较多 always 大量
fruitfly default WORLDSETTINGS_giants 果蝇王 never 无 rare 很少 default 默认 often 较多 always 大量
krampus default WORLDSETTINGS_global 坎普斯 never 无 rare 很少 default 默认 often 较多 always 大量
autumn default WORLDSETTINGS_global 秋 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
spring default WORLDSETTINGS_global 春 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
specialevent default WORLDSETTINGS_global 活动 none 无 default 自动 crow_carnival 盛夏鸦年华 hallowed_nights 万圣夜 winters_feast 冬季盛宴 year_of_the_gobbler 火鸡之年 year_of_the_varg 座狼之年 year_of_the_pig 猪王之年 year_of_the_carrat 胡萝卜鼠之年 year_of_the_beefalo 皮弗娄牛之年
beefaloheat default WORLDSETTINGS_global 皮弗娄牛交配频率 never 无 rare 很少 default 默认 often 较多 always 大量
winter default WORLDSETTINGS_global 冬 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
day default WORLDSETTINGS_global 昼夜选项 default 默认 longday 长 白天 longdusk 长 黄昏 longnight 长 夜晚 noday 无 白天 nodusk 无 黄昏 nonight 无 夜晚 onlyday 仅 白天 onlydusk 仅 黄昏 onlynight 仅 夜晚
summer default WORLDSETTINGS_global 夏 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
rocky_setting default WORLDSETTINGS_animals 石虾 never 无 rare 很少 default 默认 often 较多 always 大量
monkey_setting default WORLDSETTINGS_animals 穴居猴 never 无 rare 很少 default 默认 often 较多 always 大量
moles_setting default WORLDSETTINGS_animals 鼹鼠 never 无 rare 很少 default 默认 often 较多 always 大量
dustmoths default WORLDSETTINGS_animals 尘蛾 never 无 rare 很少 default 默认 often 较多 always 大量
snurtles default WORLDSETTINGS_animals 蜗牛龟 never 无 rare 很少 default 默认 often 较多 always 大量
slurtles_setting default WORLDSETTINGS_animals 蛞蝓龟 never 无 rare 很少 default 默认 often 较多 always 大量
grassgekkos default WORLDSETTINGS_animals 草壁虎转化 never 无 rare 很少 default 默认 often 较多 always 大量
lightfliers default WORLDSETTINGS_animals 球状光虫 never 无 rare 很少 default 默认 often 较多 always 大量
bunnymen_setting default WORLDSETTINGS_animals 兔人 never 无 rare 很少 default 默认 often 较多 always 大量
pigs_setting default WORLDSETTINGS_animals 猪 never 无 rare 很少 default 默认 often 较多 always 大量
mushgnome default WORLDSETTINGS_animals 蘑菇地精 never 无 rare 很少 default 默认 often 较多 always 大量
pirateraids default WORLDSETTINGS_monsters 月亮码头海盗 never 无 rare 很少 default 默认 often 较多 always 大量
spiders_setting default WORLDSETTINGS_monsters 蜘蛛 never 无 rare 很少 default 默认 often 较多 always 大量
bats_setting default WORLDSETTINGS_monsters 蝙蝠 never 无 rare 很少 default 默认 often 较多 always 大量
spider_dropper default WORLDSETTINGS_monsters 穴居悬蛛 never 无 rare 很少 default 默认 often 较多 always 大量
spider_warriors default WORLDSETTINGS_monsters 蜘蛛战士 never 无 default 默认
merms default WORLDSETTINGS_monsters 鱼人 never 无 rare 很少 default 默认 often 较多 always 大量
spider_spitter default WORLDSETTINGS_monsters 喷射蜘蛛 never 无 rare 很少 default 默认 often 较多 always 大量
spider_hider default WORLDSETTINGS_monsters 洞穴蜘蛛 never 无 rare 很少 default 默认 often 较多 always 大量
nightmarecreatures default WORLDSETTINGS_monsters 遗迹梦魇 never 无 rare 很少 default 默认 often 较多 always 大量
molebats default WORLDSETTINGS_monsters 裸鼹鼠蝙蝠 never 无 rare 很少 default 默认 often 较多 always 大量
flower_cave_regrowth default WORLDSETTINGS_resources 荧光花 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
regrowth default WORLDSETTINGS_resources 重生速度 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
mushtree_moon_regrowth default WORLDSETTINGS_resources 月亮蘑菇树 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
mushtree_regrowth default WORLDSETTINGS_resources 蘑菇树 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
lightflier_flower_regrowth default WORLDSETTINGS_resources 球状光虫花 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
spawnprotection default WORLDSETTINGS_survivors 防骚扰出生保护 never 无 default 自动检测 always 总是
seasonalstartingitems default WORLDSETTINGS_survivors 季节起始物品 never 无 default 默认
extrastartingitems default WORLDSETTINGS_survivors 额外起始资源 0 总是 5 第5天后 default 第10天后 15 第15天后 20 第20天后 none 从不
shadowcreatures default WORLDSETTINGS_survivors 理智怪兽 never 无 rare 很少 default 默认 often 较多 always 大量
brightmarecreatures default WORLDSETTINGS_survivors 启蒙怪兽 never 无 rare 很少 default 默认 often 较多 always 大量
dropeverythingondespawn default WORLDSETTINGS_survivors 离开游戏后物品掉落 default 默认 always 所有
atriumgate default WORLDSETTINGS_misc 远古大门 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
earthquakes default WORLDSETTINGS_misc 地震 never 无 rare 很少 default 默认 often 较多 always 大量
weather default WORLDSETTINGS_misc 雨 never 无 rare 很少 default 默认 often 较多 always 大量
wormattacks default WORLDSETTINGS_misc 洞穴蠕虫攻击 never 无 rare 很少 default 默认 often 较多 always 大量
layout_mode RestrictNodesByKey other 其他
start_location caves other 其他
task_set cave_default other 其他
wormhole_prefab tentacle_pillar other 其他
EOF

  cat >$data_dir/clusterdata.txt <<-EOF
cluster_name 由哉亚创建! 房间名称 [NETWORK] read
cluster_description 由哉亚创建! 房间简介 [NETWORK] read
cluster_intention social 游戏风格 [NETWORK] choose social 休闲 cooperative 合作 competitive 竞赛 madness 疯狂
game_mode survival 游戏模式 [GAMEPLAY] choose endless 无尽 survival 生存 wilderness 荒野 lavaarena 熔炉 quagmire 暴食
cluster_language zh 游戏语言 [NETWORK] choose zh 简体中文 en 英语
steam_group_id 0 Steam群组ID [STEAM] read
steam_group_admins false 群组官员设为管理员 [STEAM] choose true 开启 false 关闭
steam_group_only false 仅群组成员可进 [STEAM] choose true 开启 false 关闭
pause_when_empty true 无人暂停 [GAMEPLAY] choose true 开启 false 关闭
vote_enabled true 投票 [GAMEPLAY] choose true 开启 false 关闭
pvp false PVP竞技 [GAMEPLAY] choose true 开启 false 关闭
whitelist_slots 0 房间预留位置个数 [NETWORK] read
idle_timeout 0 挂机超时踢出时间 [NETWORK] read
max_snapshots 10 最大存档快照数 [MISC] read
cluster_password 无 房间密码[设无密码请输入无！！！] [NETWORK] read
max_players 6 最大玩家人数 [GAMEPLAY] read
master_ip 127.0.0.1 主世界IP(多服务器必须修改此项) [SHARD] read
lan_only_cluster false 仅局域网 [NETWORK] readonly
offline_cluster false 离线模式 [NETWORK] readonly
autosaver_enabled true 自动保存 [NETWORK] readonly
tick_rate 15 主客机同步频率 [NETWORK] readonly
console_enabled true 控制台 [MISC] readonly
shard_enabled true 多世界 [SHARD] readonly
bind_ip 0.0.0.0 绑定IP [SHARD] readonly
master_port 10888 游戏端口 [SHARD] readonly
cluster_key Ariwori 多世界通信秘钥 [SHARD] readonly
EOF

  cat >$data_dir/Masterend.lua <<-EOF
},
  ["random_set_pieces"]={
    "Sculptures_2",
    "Sculptures_3",
    "Sculptures_4",
    "Sculptures_5",
    "Chessy_1",
    "Chessy_2",
    "Chessy_3",
    "Chessy_4",
    "Chessy_5",
    "Chessy_6",
    "Maxwell1",
    "Maxwell2",
    "Maxwell3",
    "Maxwell4",
    "Maxwell6",
    "Maxwell7",
    "Warzone_1",
    "Warzone_2",
    "Warzone_3"
  },
  ["required_prefabs"]={ "multiplayer_portal" },
  ["required_setpieces"]={ "Sculptures_1", "Maxwell5" },
  ["substitutes"]={},
  ["version"]=4,
  ["settings_desc"]="标准《饥荒》体验。",
  ["settings_id"]="SURVIVAL_TOGETHER",
  ["settings_name"]="标准森林",
  ["worldgen_desc"]="标准《饥荒》体验。",
  ["worldgen_id"]="SURVIVAL_TOGETHER",
  ["worldgen_name"]="标准森林"
}
EOF

  cat >$data_dir/Masterstart.lua <<-EOF
return {
  ["desc"]="由哉亚创建!",
  ["hideminimap"]=false,
  id="SURVIVAL_TOGETHER",
  ["location"]="forest",
  ["max_playlist_position"]=999,
  ["min_playlist_position"]=0,
  ["name"]="游山玩水--由哉亚创建!",
  ["numrandom_set_pieces"]=4,
  ["override_level_string"]=false,
  overrides={
    ["has_ocean"]=true,
    ["no_joining_islands"]=true,
    ["no_wormholes_to_disconnected_tiles"]=true,
    ["keep_disconnected_tiles"]=true,
EOF

  cat >$data_dir/Masterleveldata.txt <<-EOF
branching default WORLDGEN_misc 分支 never 从不 least 最少 default 默认 most 最多 random 随机
touchstone default WORLDGEN_misc 试金石 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
world_size default WORLDGEN_misc 世界大小 small 小 medium 中 default 大 huge 巨大
prefabswaps_start default WORLDGEN_misc 开始资源多样化 classic 经典 default 默认 highlyrandom 非常随机
loop default WORLDGEN_misc 环形 never 从不 default 默认 always 总是
moon_fissure default WORLDGEN_misc 天体裂隙 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
terrariumchest default WORLDGEN_misc 泰拉瑞亚 never 无 default 默认
roads default WORLDGEN_misc 道路 never 无 default 默认
boons default WORLDGEN_misc 失败的冒险家 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
start_location default WORLDGEN_misc 出生点 lavaarena 默认 plus 额外资源 darkness 黑暗 quagmire_startlocation 默认 caves 洞穴 default 默认
task_set default WORLDGEN_misc 生物群落 default 联机版 cave_default 地下 quagmire_taskset 暴食 classic 经典 lavaarena_taskset 熔炉
season_start default WORLDGEN_global 起始季节 default 秋 winter 冬 spring 春 summer 夏 autumn|spring 春或秋 winter|summer 冬季或夏季 autumn|winter|spring|summer 随机
beefalo default WORLDGEN_animals 皮弗娄牛 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
lightninggoat default WORLDGEN_animals 伏特羊 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
catcoon default WORLDGEN_animals 空心树桩 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
rabbits default WORLDGEN_animals 兔洞 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_fruitdragon default WORLDGEN_animals 沙拉蝾螈 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
ocean_wobsterden default WORLDGEN_animals 龙虾窝 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moles default WORLDGEN_animals 鼹鼠洞 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
ocean_shoal default WORLDGEN_animals 鱼群 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
bees default WORLDGEN_animals 蜜蜂蜂窝 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
pigs default WORLDGEN_animals 猪屋 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
buzzard default WORLDGEN_animals 秃鹫 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_carrot default WORLDGEN_animals 胡萝卜鼠 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
tallbirds default WORLDGEN_monsters 高脚鸟 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
walrus default WORLDGEN_monsters 海象营地 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
spiders default WORLDGEN_monsters 蜘蛛巢 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
ocean_waterplant ocean_default WORLDGEN_monsters 海草 ocean_never 无 ocean_rare 很少 ocean_uncommon 较少 ocean_default 默认 ocean_often 较多 ocean_mostly 很多 ocean_always 大量 ocean_insane 疯狂
angrybees default WORLDGEN_monsters 杀人蜂蜂窝 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
tentacles default WORLDGEN_monsters 触手 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_spiders default WORLDGEN_monsters 破碎蜘蛛洞 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
chess default WORLDGEN_monsters 发条装置 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
houndmound default WORLDGEN_monsters 猎犬丘 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
merm default WORLDGEN_monsters 漏雨的小屋 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
grass default WORLDGEN_resources 草 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
rock default WORLDGEN_resources 巨石 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
ocean_seastack ocean_default WORLDGEN_resources 浮堆 ocean_never 无 ocean_rare 很少 ocean_uncommon 较少 ocean_default 默认 ocean_often 较多 ocean_mostly 很多 ocean_always 大量 ocean_insane 疯狂
ocean_bullkelp default WORLDGEN_resources 公牛海带 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
mushroom default WORLDGEN_resources 蘑菇 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
flowers default WORLDGEN_resources 花，邪恶花 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_berrybush default WORLDGEN_resources 石果灌木丛 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
ponds default WORLDGEN_resources 池塘 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_bullkelp default WORLDGEN_resources 海岸公牛海带 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_starfish default WORLDGEN_resources 海星 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
sapling default WORLDGEN_resources 树苗 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_hotspring default WORLDGEN_resources 温泉 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
rock_ice default WORLDGEN_resources 迷你冰川 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_sapling default WORLDGEN_resources 月亮树苗 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
berrybush default WORLDGEN_resources 浆果丛 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
meteorspawner default WORLDGEN_resources 流星区域 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
trees default WORLDGEN_resources 树（所有） never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
reeds default WORLDGEN_resources 芦苇 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_tree default WORLDGEN_resources 月树 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
flint default WORLDGEN_resources 燧石 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
tumbleweed default WORLDGEN_resources 风滚草 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
palmconetree default WORLDGEN_resources 棕榈松果树 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
carrot default WORLDGEN_resources 胡萝卜 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
cactus default WORLDGEN_resources 仙人掌 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
marshbush default WORLDGEN_resources 尖灌木 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
moon_rock default WORLDGEN_resources 月亮石 never 无 rare 很少 uncommon 较少 default 默认 often 较多 mostly 很多 always 大量 insane 疯狂
eyeofterror default WORLDSETTINGS_giants 恐怖之眼 never 无 rare 很少 default 默认 often 较多 always 大量
crabking default WORLDSETTINGS_giants 帝王蟹 never 无 rare 很少 default 默认 often 较多 always 大量
spiderqueen default WORLDSETTINGS_giants 蜘蛛女王 never 无 rare 很少 default 默认 often 较多 always 大量
bearger default WORLDSETTINGS_giants 熊獾 never 无 rare 很少 default 默认 often 较多 always 大量
liefs default WORLDSETTINGS_giants 树精守卫 never 无 rare 很少 default 默认 often 较多 always 大量
dragonfly default WORLDSETTINGS_giants 龙蝇 never 无 rare 很少 default 默认 often 较多 always 大量
deerclops default WORLDSETTINGS_giants 独眼巨鹿 never 无 rare 很少 default 默认 often 较多 always 大量
klaus default WORLDSETTINGS_giants 克劳斯 never 无 rare 很少 default 默认 often 较多 always 大量
deciduousmonster default WORLDSETTINGS_giants 毒桦栗树 never 无 rare 很少 default 默认 often 较多 always 大量
beequeen default WORLDSETTINGS_giants 蜂王 never 无 rare 很少 default 默认 often 较多 always 大量
malbatross default WORLDSETTINGS_giants 邪天翁 never 无 rare 很少 default 默认 often 较多 always 大量
antliontribute default WORLDSETTINGS_giants 蚁狮贡品 never 无 rare 很少 default 默认 often 较多 always 大量
fruitfly default WORLDSETTINGS_giants 果蝇王 never 无 rare 很少 default 默认 often 较多 always 大量
goosemoose default WORLDSETTINGS_giants 麋鹿鹅 never 无 rare 很少 default 默认 often 较多 always 大量
krampus default WORLDSETTINGS_global 坎普斯 never 无 rare 很少 default 默认 often 较多 always 大量
autumn default WORLDSETTINGS_global 秋 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
spring default WORLDSETTINGS_global 春 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
specialevent default WORLDSETTINGS_global 活动 none 无 default 自动 crow_carnival 盛夏鸦年华 hallowed_nights 万圣夜 winters_feast 冬季盛宴 year_of_the_gobbler 火鸡之年 year_of_the_varg 座狼之年 year_of_the_pig 猪王之年 year_of_the_carrat 胡萝卜鼠之年 year_of_the_beefalo 皮弗娄牛之年
beefaloheat default WORLDSETTINGS_global 皮弗娄牛交配频率 never 无 rare 很少 default 默认 often 较多 always 大量
winter default WORLDSETTINGS_global 冬 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
day default WORLDSETTINGS_global 昼夜选项 default 默认 longday 长白天 longdusk 长黄昏 longnight 长夜晚 noday 无白天 nodusk 无黄昏 nonight 无夜晚 onlyday 仅白天 onlydusk 仅黄昏 onlynight 仅夜晚
summer default WORLDSETTINGS_global 夏 noseason 无 veryshortseason 极短 shortseason 短 default 默认 longseason 长 verylongseason 极长 random 随机
fishschools default WORLDSETTINGS_animals 鱼群 never 无 rare 很少 default 默认 often 较多 always 大量
birds default WORLDSETTINGS_animals 鸟 never 无 rare 很少 default 默认 often 较多 always 大量
rabbits_setting default WORLDSETTINGS_animals 兔子 never 无 rare 很少 default 默认 often 较多 always 大量
perd default WORLDSETTINGS_animals 火鸡 never 无 rare 很少 default 默认 often 较多 always 大量
bees_setting default WORLDSETTINGS_animals 蜜蜂 never 无 rare 很少 default 默认 often 较多 always 大量
penguins default WORLDSETTINGS_animals 企鸥 never 无 rare 很少 default 默认 often 较多 always 大量
moles_setting default WORLDSETTINGS_animals 鼹鼠 never 无 rare 很少 default 默认 often 较多 always 大量
gnarwail default WORLDSETTINGS_animals 一角鲸 never 无 rare 很少 default 默认 often 较多 always 大量
butterfly default WORLDSETTINGS_animals 蝴蝶 never 无 rare 很少 default 默认 often 较多 always 大量
catcoons default WORLDSETTINGS_animals 浣猫 never 无 rare 很少 default 默认 often 较多 always 大量
grassgekkos default WORLDSETTINGS_animals 草壁虎转化 never 无 rare 很少 default 默认 often 较多 always 大量
bunnymen_setting default WORLDSETTINGS_animals 兔人 never 无 rare 很少 default 默认 often 较多 always 大量
pigs_setting default WORLDSETTINGS_animals 猪 never 无 rare 很少 default 默认 often 较多 always 大量
wobsters default WORLDSETTINGS_animals 龙虾 never 无 rare 很少 default 默认 often 较多 always 大量
sharks default WORLDSETTINGS_monsters 鲨鱼 never 无 rare 很少 default 默认 often 较多 always 大量
spiders_setting default WORLDSETTINGS_monsters 蜘蛛 never 无 rare 很少 default 默认 often 较多 always 大量
mutated_hounds default WORLDSETTINGS_monsters 恐怖猎犬 never 无 default 默认
squid default WORLDSETTINGS_monsters 鱿鱼 never 无 rare 很少 default 默认 often 较多 always 大量
penguins_moon default WORLDSETTINGS_monsters 月石企鸥 never 无 default 默认
moon_spider default WORLDSETTINGS_monsters 破碎蜘蛛 never 无 rare 很少 default 默认 often 较多 always 大量
bats_setting default WORLDSETTINGS_monsters 蝙蝠 never 无 rare 很少 default 默认 often 较多 always 大量
lureplants default WORLDSETTINGS_monsters 食人花 never 无 rare 很少 default 默认 often 较多 always 大量
hound_mounds default WORLDSETTINGS_monsters 猎犬 never 无 rare 很少 default 默认 often 较多 always 大量
cookiecutters default WORLDSETTINGS_monsters 饼干切割机 never 无 rare 很少 default 默认 often 较多 always 大量
mosquitos default WORLDSETTINGS_monsters 蚊子 never 无 rare 很少 default 默认 often 较多 always 大量
wasps default WORLDSETTINGS_monsters 杀人蜂 never 无 rare 很少 default 默认 often 较多 always 大量
frogs default WORLDSETTINGS_monsters 青蛙 never 无 rare 很少 default 默认 often 较多 always 大量
spider_warriors default WORLDSETTINGS_monsters 蜘蛛战士 never 无 default 默认
merms default WORLDSETTINGS_monsters 鱼人 never 无 rare 很少 default 默认 often 较多 always 大量
walrus_setting default WORLDSETTINGS_monsters 海象 never 无 rare 很少 default 默认 often 较多 always 大量
regrowth default WORLDSETTINGS_resources 重生速度 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
saltstack_regrowth default WORLDSETTINGS_resources 盐堆 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
palmcone_seed_portalrate default WORLDSETTINGS_resources 棕榈松果树 never 无 veryslow 极慢 slow 慢 default 默认  fast 快 veryfast 极快
carrots_regrowth default WORLDSETTINGS_resources 胡萝卜 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
deciduoustree_regrowth default WORLDSETTINGS_resources 桦栗树 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
flowers_regrowth default WORLDSETTINGS_resources 花 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
moon_tree_regrowth default WORLDSETTINGS_resources 月树 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
evergreen_regrowth default WORLDSETTINGS_resources 常青树 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
twiggytrees_regrowth default WORLDSETTINGS_resources 多枝树 never 无 veryslow 极慢 slow 慢 default 默认 fast 快 veryfast 极快
spawnprotection default WORLDSETTINGS_survivors 防骚扰出生保护 never 无 default 自动检测 always 总是
seasonalstartingitems default WORLDSETTINGS_survivors 季节起始物品 never 无 default 默认
extrastartingitems default WORLDSETTINGS_survivors 额外起始资源 0 总是 5 第5天后 default 第10天后 15 第15天后 20 第20天后 none 从不
shadowcreatures default WORLDSETTINGS_survivors 理智怪兽 never 无 rare 很少 default 默认 often 较多 always 大量
brightmarecreatures default WORLDSETTINGS_survivors 启蒙怪兽 never 无 rare 很少 default 默认 often 较多 always 大量
dropeverythingondespawn default WORLDSETTINGS_survivors 离开游戏后物品掉落 default 默认 always 所有
meteorshowers default WORLDSETTINGS_misc 流星频率 never 无 rare 很少 default 默认 often 较多 always 大量
hunt default WORLDSETTINGS_misc 狩猎 never 无 rare 很少 default 默认 often 较多 always 大量
alternatehunt default WORLDSETTINGS_misc 追猎惊喜 never 无 rare 很少 default 默认 often 较多 always 大量
lightning default WORLDSETTINGS_misc 闪电 never 无 rare 很少 default 默认 often 较多 always 大量
weather default WORLDSETTINGS_misc 雨 never 无 rare 很少 default 默认 often 较多 always 大量
hounds default WORLDSETTINGS_misc 猎犬袭击 never 无 rare 很少 default 默认 often 较多 always 大量
frograin default WORLDSETTINGS_misc 青蛙雨 never 无 rare 很少 default 默认 often 较多 always 大量
wildfires default WORLDSETTINGS_misc 野火 never 无 rare 很少 default 默认 often 较多 always 大量
petrification default WORLDSETTINGS_misc 森林石化 none 无 few 慢 default 默认 many 快 max 极快
layout_mode LinkNodesByKeys other 其他
wormhole_prefab wormhole other 虫洞生物
EOF

  cat >$data_dir/quagmire.lua <<-EOF
return {
  background_node_range={ 0, 0 },
  desc="你能经受暴食的挑战吗？--由哉亚创建!",
  hideminimap=false,
  id="QUAGMIRE",
  location="quagmire",
  max_playlist_position=999,
  min_playlist_position=0,
  name="暴食：你会做饭吗？--由哉亚创建!",
  numrandom_set_pieces=0,
  override_level_string=false,
  overrides={
    boons="never",
    branching="random",
    disease_delay="none",
    keep_disconnected_tiles=false,
    layout_mode="RestrictNodesByKey",
    loop_percent=0,
    no_joining_islands=true,
    no_wormholes_to_disconnected_tiles=true,
    petrification="none",
    poi="never",
    prefabswaps_start="classic",
    protected="never",
    roads="never",
    season_start="default",
    start_location="quagmire_startlocation",
    task_set="quagmire_taskset",
    touchstone="never",
    traps="never",
    wildfires="never",
    world_size="small"
  },
  required_prefabs={ "quagmire_portal" },
  substitutes={  },
  version=4
}
EOF

  cat >$data_dir/lavaarena.lua <<-EOF
return {
    background_node_range={ 0, 1 },
    desc="由哉亚创建!",
    hideminimap=false,
    id="LAVAARENA",
    location="lavaarena",
    max_playlist_position=999,
    min_playlist_position=0,
    name="熔炉斗兽场--由哉亚创建!",
    numrandom_set_pieces=0,
    override_level_string=false,
    overrides={
      has_ocean=false,
      boons="never",
      keep_disconnected_tiles=true,
      layout_mode="RestrictNodesByKey",
      poi="never",
      protected="never",
      roads="never",
      season_start="default",
      start_location="lavaarena",
      task_set="lavaarena_taskset",
      touchstone="never",
      traps="never",
      world_size="small"
    },
    required_prefabs={ "lavaarena_portal" },
    substitutes={  },
    version=4
  }
EOF

  cat >$data_dir/lavaarena1.lua <<-EOF
return {
  ["background_node_range"]={ 0, 1 },
  ["desc"]="你敢进入熔炉证明自己吗？",
  ["hideminimap"]=false,
  id="LAVAARENA",
  ["location"]="lavaarena",
  ["max_playlist_position"]=999,
  ["min_playlist_position"]=0,
  ["name"]="熔炉斗兽场--由哉亚创建!",
  ["numrandom_set_pieces"]=0,
  ["override_level_string"]=false,
  ["overrides"]={
    ["boons"]="never",
    ["keep_disconnected_tiles"]=true,
    ["layout_mode"]="RestrictNodesByKey",
    ["no_joining_islands"]=true,
    ["no_wormholes_to_disconnected_tiles"]=true,
    ["poi"]="never",
    ["protected"]="never",
    ["roads"]="never",
    ["season_start"]="default",
    ["start_location"]="lavaarena",
    ["task_set"]="lavaarena_taskset",
    ["touchstone"]="never",
    ["traps"]="never",
    ["world_size"]="small"
  },
  ["required_prefabs"]={ "lavaarena_portal" },
  ["substitutes"]={  },
  ["version"]=4
}
  cat >$data_dir/modconf.lua <<-EOF
require "modinfo"

-- Addon function
function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function LuaRemove(str,remove)
    local lcSubStrTab = {}
    while true do
    local lcPos = string.find(str,remove)
    if not lcPos then
      lcSubStrTab[#lcSubStrTab+1] =  str
      break
    end
    local lcSubStr  = string.sub(str,1,lcPos-1)
    lcSubStrTab[#lcSubStrTab+1] = lcSubStr
    str = string.sub(str,lcPos+1,#str)
    end
    local lcMergeStr =""
    local lci = 1
    while true do
    if lcSubStrTab[lci] then
      lcMergeStr = lcMergeStr .. lcSubStrTab[lci]
      lci = lci + 1
    else
      break
    end
    end
    return lcMergeStr
end
function Blank2jin(str)
    return (string.gsub(str, " ", "#"))
end
---
function list()
    if used == "true" then
    used = "[已启用]:"
    else
    used = "[未启用]:"
    end
    if modid == nil then
    modid = "unknown"
    end
    if name ~= nil then
    name = trim(name)
    name = LuaRemove(name, "\n")
    else
    name = "Unknown"
    end
    if configuration_options ~= nil and #configuration_options > 0 then
    cfg = "[可配置]:"
    else
    cfg = "[无配置]:"
    end
    local f = assert(io.open("modconflist.lua", 'a'))
    f:write(used, cfg, modid, ":", name, "\n")
    f:close()
end

function getver()
    print(version)
end

function table2json(t)
    local function serialize(tbl)
    local tmp = {}
    for k, v in pairs(tbl) do
      local k_type = type(k)
      local v_type = type(v)
      local key = (k_type == "string" and "\"" .. k .. "\":")
        or (k_type == "number" and "")
      local value = (v_type == "table" and serialize(v))
        or (v_type == "boolean" and tostring(v))
        or (v_type == "string" and "\"" .. v .. "\"")
        or (v_type == "number" and v)
        tmp[#tmp + 1] = key and value and tostring(key) .. tostring(value) or nil
    end
    if table.maxn(tbl) == 0 then
      return "{" .. table.concat(tmp, ",") .. "}"
    else
      return "[" .. table.concat(tmp, ",") .. "]"
    end
    end
    assert(type(t) == "table")
    return serialize(t)
end

function getname()
    if name then
    name = trim(name)
    name = LuaRemove(name, "\n")
    else
    name = "unknown"
    end
    print(name)
end

function createmodcfg()
    fname = "modconfigure/" .. modid .. ".cfg"
    local f = assert(io.open(fname, 'w'))
    f:write("mod-version = " .. version .. "\n")
    if name ~= nil then
    name = trim(name)
    name = Blank2jin(name)
    name = LuaRemove(name, "\n")
    end
    f:write("mod-name = " .. name .. "\n")
    if configuration_options ~= nil and #configuration_options > 0 then
    f:write("mod-configureable = true\n")
    for i, j in pairs(configuration_options) do
      if j.default == nil then
        if j.options ~= nil and #j.options > 0 then
          j.default = j.options[1].data
        end
      end
      if j.default ~= nil then
        local label = "nolabel"
        if j.label ~= nil then
          if string.len(j.label) >= 2 then
            label = Blank2jin(j.label)
            label = LuaRemove(label, "\n")
          end
        end
        local hover = "该项没有简介！"
        if j.hover ~= nil then
          if string.len(j.hover) >= 2 then
            hover = Blank2jin(j.hover)
            hover = LuaRemove(hover, "\n")
          end
        end
        local cfgname = Blank2jin(j.name)
        cfgname = LuaRemove(cfgname, "\n")
        if type(j.default) == "table" then
          f:write(cfgname .. " 表数据请直接修改modinfo.lua文件 table " .. label .. " " .. hover .. "\n")
        else
          f:write(cfgname .. " " .. tostring(j.default) .. " " .. type(j.default) .. " " .. label .. " " .. hover .. " ")
          if j.options ~= nil and #j.options > 0 then
            for k, v in pairs(j.options) do
              if type(v.data) ~= "table" then
                local description = ""
                if v.description ~= nil then
                  if string.len(v.description) >= 2 then
                    description = Blank2jin(v.description)
                    description = LuaRemove(description, "\n")
                  end
                end
                if description == "" then
                  description = tostring(v.data)
                end
                local cfghover = "该项没有说明！"
                if v.hover ~= nil then
                  if string.len(v.hover) >= 2 then
                    cfghover = v.hover
                  end
                end
                cfghover = Blank2jin(cfghover)
                cfghover = LuaRemove(cfghover, "\n")
                f:write(tostring(v.data) .. " " .. description .. " " .. cfghover)
              end
              if k ~= #j.options then
                f:write(" ")
              else
                f:write("\n")
              end
            end
          end
        end
      end
    end
    else
    f:write("mod-configureable = false\n")
    end
    f:close()
end
---------------------------------
if fuc == "list" then
    list()
elseif fuc == "getver" then
    getver()
elseif fuc == "getname" then
    getname()
elseif fuc == "createmodcfg" then
    createmodcfg()
end
EOF
}
queshi()
{
  if [[ ! -f $data_dir/modconf.lua ]];then
  cat >$data_dir/modconf.lua <<-EOF
require "modinfo"

-- Addon function
function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function LuaRemove(str,remove)
    local lcSubStrTab = {}
    while true do
    local lcPos = string.find(str,remove)
    if not lcPos then
      lcSubStrTab[#lcSubStrTab+1] =  str
      break
    end
    local lcSubStr  = string.sub(str,1,lcPos-1)
    lcSubStrTab[#lcSubStrTab+1] = lcSubStr
    str = string.sub(str,lcPos+1,#str)
    end
    local lcMergeStr =""
    local lci = 1
    while true do
    if lcSubStrTab[lci] then
      lcMergeStr = lcMergeStr .. lcSubStrTab[lci]
      lci = lci + 1
    else
      break
    end
    end
    return lcMergeStr
end
function Blank2jin(str)
    return (string.gsub(str, " ", "#"))
end
---
function list()
    if used == "true" then
    used = "[已启用]:"
    else
    used = "[未启用]:"
    end
    if modid == nil then
    modid = "unknown"
    end
    if name ~= nil then
    name = trim(name)
    name = LuaRemove(name, "\n")
    else
    name = "Unknown"
    end
    if configuration_options ~= nil and #configuration_options > 0 then
    cfg = "[可配置]:"
    else
    cfg = "[无配置]:"
    end
    local f = assert(io.open("modconflist.lua", 'a'))
    f:write(used, cfg, modid, ":", name, "\n")
    f:close()
end

function getver()
    print(version)
end

function table2json(t)
    local function serialize(tbl)
    local tmp = {}
    for k, v in pairs(tbl) do
      local k_type = type(k)
      local v_type = type(v)
      local key = (k_type == "string" and "\"" .. k .. "\":")
        or (k_type == "number" and "")
      local value = (v_type == "table" and serialize(v))
        or (v_type == "boolean" and tostring(v))
        or (v_type == "string" and "\"" .. v .. "\"")
        or (v_type == "number" and v)
        tmp[#tmp + 1] = key and value and tostring(key) .. tostring(value) or nil
    end
    if table.maxn(tbl) == 0 then
      return "{" .. table.concat(tmp, ",") .. "}"
    else
      return "[" .. table.concat(tmp, ",") .. "]"
    end
    end
    assert(type(t) == "table")
    return serialize(t)
end

function getname()
    if name then
    name = trim(name)
    name = LuaRemove(name, "\n")
    else
    name = "unknown"
    end
    print(name)
end

function createmodcfg()
    fname = "modconfigure/" .. modid .. ".cfg"
    local f = assert(io.open(fname, 'w'))
    f:write("mod-version = " .. version .. "\n")
    if name ~= nil then
    name = trim(name)
    name = Blank2jin(name)
    name = LuaRemove(name, "\n")
    end
    f:write("mod-name = " .. name .. "\n")
    if configuration_options ~= nil and #configuration_options > 0 then
    f:write("mod-configureable = true\n")
    for i, j in pairs(configuration_options) do
      if j.default == nil then
        if j.options ~= nil and #j.options > 0 then
          j.default = j.options[1].data
        end
      end
      if j.default ~= nil then
        local label = "nolabel"
        if j.label ~= nil then
          if string.len(j.label) >= 2 then
            label = Blank2jin(j.label)
            label = LuaRemove(label, "\n")
          end
        end
        local hover = "该项没有简介！"
        if j.hover ~= nil then
          if string.len(j.hover) >= 2 then
            hover = Blank2jin(j.hover)
            hover = LuaRemove(hover, "\n")
          end
        end
        local cfgname = Blank2jin(j.name)
        cfgname = LuaRemove(cfgname, "\n")
        if type(j.default) == "table" then
          f:write(cfgname .. " 表数据请直接修改modinfo.lua文件 table " .. label .. " " .. hover .. "\n")
        else
          f:write(cfgname .. " " .. tostring(j.default) .. " " .. type(j.default) .. " " .. label .. " " .. hover .. " ")
          if j.options ~= nil and #j.options > 0 then
            for k, v in pairs(j.options) do
              if type(v.data) ~= "table" then
                local description = ""
                if v.description ~= nil then
                  if string.len(v.description) >= 2 then
                    description = Blank2jin(v.description)
                    description = LuaRemove(description, "\n")
                  end
                end
                if description == "" then
                  description = tostring(v.data)
                end
                local cfghover = "该项没有说明！"
                if v.hover ~= nil then
                  if string.len(v.hover) >= 2 then
                    cfghover = v.hover
                  end
                end
                cfghover = Blank2jin(cfghover)
                cfghover = LuaRemove(cfghover, "\n")
                f:write(tostring(v.data) .. " " .. description .. " " .. cfghover)
              end
              if k ~= #j.options then
                f:write(" ")
              else
                f:write("\n")
              end
            end
          end
        end
      end
    end
    else
    f:write("mod-configureable = false\n")
    end
    f:close()
end
---------------------------------
if fuc == "list" then
    list()
elseif fuc == "getver" then
    getver()
elseif fuc == "getname" then
    getname()
elseif fuc == "createmodcfg" then
    createmodcfg()
end
EOF
  fi
}
MOD_manager() {
      while (true); do
        echo -e "\e[92m 你要\n1.添加mod       2.删除mod      3.修改MOD配置 \n4.重置MOD配置   5.安装MOD合集  6.返回主菜单\n：\e[0m\c"
        read mc
        case "${mc}" in
        1)
          Listallmod
          Addmod
          ;;
        2)
          flag=true
          Listusedmod
          if [[ $flag == "true" ]]
          then
            Delmod
          fi
          ;;
        3)
          Mod_Cfg
          ;;
        4)
          clear_mod_cfg
          ;;
        5)
          Install_mod_collection
          ;;
        6)
          tip "MOD的更改必须重启服务器后才会生效！！！"
          break
          ;;
        *)
          error "输入有误！！！"
          ;;
        esac
      done
      Removelastcomma
}
Install_mod_collection() {
  [ -f "$data_dir/modcollectionlist.txt" ] && rm -rf "$data_dir/modcollectionlist.txt"
  touch "$data_dir/modcollectionlist.txt"
  echo -e "\e[92m[输入结束请输入数字 0]请输入你的MOD合集ID:\e[0m\c"
    read clid
    if [ $clid -eq 0 ]; then
      info "合集添加完毕！即将安装 ..."
      break
    else
      echo "ServerModCollectionSetup(\"$clid\")" >>"$data_dir/modcollectionlist.txt"
      info "该MOD合集($clid)已添加到待安装列表。"
    fi
  if [ -s "$data_dir/modcollectionlist.txt" ]; then
    info "正在安装新添加的MOD(合集)，请稍候 。。。"
    cp "$data_dir/modcollectionlist.txt" "${dst_server_dir}/mods/dedicated_server_mods_setup.lua"
    modup
    echo "安装进程已执行完毕，请到添加MOD中查看是否安装成功！"
    sleep 3
  else
    tip "没有新的MOD合集需要安装！"
  fi
}
Listallmod() {
  if [ ! -f "${data_dir}/mods_setup.lua" ]; then
    touch "${data_dir}/mods_setup.lua"
  fi
  rm -f "${data_dir}/modconflist.lua"
  touch "${data_dir}/modconflist.lua"
	cd $MyDediServers
  allsave=$(ls -l  | grep ^d | awk '{print $9}')
  for shard in ${allsave}; do
  for moddir in $(ls -F "${dst_server_dir}/mods" | grep "/$" | cut -d '/' -f1); do
    if [ $(grep "${moddir}" -c "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua") -gt 0 ]; then
      used="true"
    else
      used="false"
    fi
    if [[ $(echo ${moddir} | grep -c '^workshop') -gt 0 ]]
    then
      moddir=$(echo ${moddir} | cut -d '-' -f2)
    fi
    if [[ "${moddir}" != "" ]]; then
      fuc="list"
      MOD_conf
    fi
  done
    for moddir in $(ls -F $parent_mod_dir | grep "/$" | cut -d '/' -f1); do
        if [ -f $parent_mod_dir/$moddir/modinfo.lua ]; then
          if [ $(grep "${moddir}" -c "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua") -gt 0 ]; then
            used="true"
          else
            used="false"
          fi
          if [[ "${moddir}" != "" ]]; then
            fuc="list"
            MOD_conf
          fi
        fi

    done
  if [ ! -s "${data_dir}/modconflist.lua" ]; then
    tip "没有安装任何MOD"
  else
    grep -n "^" "${data_dir}/modconflist.lua"
  fi
    done
}
Listusedmod() {
  rm -f "${data_dir}/modconflist.lua"
  touch "${data_dir}/modconflist.lua"
	  cd $MyDediServers
		allsave=$(ls -l  | grep ^d | awk '{print $9}')
    for shard1 in ${allsave}; do
        shard=$shard1
    done
    for moddir in $(grep "^  \[" "${dst_base_dir}/MyDediServer/${shard}/modoverrides.lua" | cut -d '"' -f2); do
    used="false"
    # if [ ! -d ${dst_server_dir}/mods/workshop-${moddir} ]
    # then
    #   moddir=$(echo ${moddir} | tr -cd '[0-9]')
    # fi
    if [[ $(echo ${moddir} | grep -c '^workshop') -gt 0 ]]
    then
      moddir=$(echo ${moddir} | cut -d '-' -f2)
    fi
    if [[ "${moddir}" != "" ]]; then
      fuc="list"
      used="true"
      MOD_conf
    fi
  done
  if [ ! -s "${data_dir}/modconflist.lua" ]; then
    tip "没有启用任何MOD，请先启用MOD！！！"
    flag=false
  else
    grep -n "^" "${data_dir}/modconflist.lua"
  fi
}
Addmod() {
  info "请从以上列表选择你要启用的MOD${Red_font_prefix}[编号]${Font_color_suffix}，不存在的直接输入MODID"
  tip "大小超过10M的MOD如果无法在服务器添加下载，请手动上传到服务器再启用！！！"
  info "添加完毕要退出请输入数字 0 ！[可输入多个，如 \"1 2 4-6 7927397293\"]"
  while (true); do
    read modid
    if [[ "${modid}" == "0" ]]; then
      info "添加完毕 ！"
      break
    fi
    if [[ "${modid}" == "" ]]; then
      error "输入不可为空值！！！"
    else
      Getinputlist "$modid"
      for modid in ${inputarray[@]}; do
        Addmodfunc
      done
    fi
  done
  #clear
  info "默认参数配置已写入配置文件，可手动修改，也可通过脚本修改："
  info "${dst_base_dir}/MyDediServer/***/modoverrides.lua"
  check_cluster_file "modoverrides.lua"
}

#启动和创建世界
function qirun()
{
  clear
	echo -e "\033[33m [提示]: 推荐使用下面的网页创建存档后保存到本地，再传到云服\033[0m"
	echo -e "\033[33m [提示]: https://dst.suke.fun/\033[0m"
  echo -e "\033[36m [提示]: [1]直接启动 [2]创建世界 [0]返回\033[0m"
	while :
		do
	echo
	read -p "请输入编号：" qirun1
		case $qirun1 in
			1)
			killallscreen
			sleep 10
			run
			Main
			break;;
#			2)xuanze
#			break;;
	    2)
	    room_set_up
	    lp
	    Addshard
	    break;;
	    0)Main
	    break;;
			*)
			echo 没有此选项请重新选择
		esac
done
}
function run()
{
#  echo 正在更新/下载模组
#  modup
	cd $MyDediServers
		allsave=$(ls -l  | grep ^d | awk '{print $9}')
    for save in ${allsave}; do
    cd "$gamesPath"
		screen -dmS "Dst $save" "$gamesFile" -skip_update_server_mods -ugc_directory ${ugc_directory} -persistent_storage_root ${dst_conf_basedir} -conf_dir ${dst_conf_dirname} -cluster MyDediServer -shard ${save}
		echo -e "\033[33m 正在启动$save\033[0m"
		sleep 2
	done
}
function jg()
{
	while :
		do
		cd $HOME
		if cat "./.klei/DoNotStarveTogether/MyDediServer/$save/server_log.txt" | grep "!!!! Your Server Will Not Start !!!!" >/dev/null 2>&1;then
			clear
			echo 警告缺失令牌!!!
			sleep 5
			break
		elif cat "./.klei/DoNotStarveTogether/MyDediServer/$save/server_log.txt" | grep "Sim paused" >/dev/null 2>&1;then
			echo 开服成功!!!
			echo 祝您游戏愉快
			sleep 5
			break
		elif cat "./.klei/DoNotStarveTogether/MyDediServer/$save/server_log.txt" | grep "Registering master server" >/dev/null 2>&1;then
			echo 开服成功!!!
			echo 祝您游戏愉快
			sleep 5
			break
		elif cat "./.klei/DoNotStarveTogether/MyDediServer/$save/server_log.txt" | grep "Server registered via geo DNS in Sing" >/dev/null 2>&1;then
			echo 挂机服开服成功!!!
			echo 祝您游戏愉快
			sleep 5
			break
		elif cat "./.klei/DoNotStarveTogether/MyDediServer/$save/server_log.txt" | grep "LUA is now ready" >/dev/null 2>&1;then
			echo 开服成功!!!
			echo 祝您游戏愉快
			sleep 5
			break
		else
			logs=$(cat ".klei/DoNotStarveTogether/MyDediServer/$save/server_log.txt" | tail -n 20)
			echo -e "\033[33m $logs\033[0m"
			echo -e "\033[34m 此页面正在检查/报错$save世界。Ctrl+c可以直接退出，不会影响服务器的开启\033[0m"
			echo -e "\033[34m 暴食请直接按住ctrl+c退出\033[0m"
			sleep 3
			fi
		done
}
function cq()
{
#	killallscreen
#	sleep 10
	run
	jg
	qidong
	Main
}
function killMaster()
{
	echo -e "\033[33m[提示] [提示] 存档位 [1-5] \033[0m"
	read input_save
	echo -e "\033[33m[提示] 地面正在关闭请稍等 \033[0m"
	for((ww=0;ww<5;ww++))
			do
		screen -S "Dst Master$input_save" -X stuff "c_announce('服务器将在10秒内关闭，请停止跳世界等操作,否则会丢失个人存档，请耐心等待！')\n"
		sleep 2
	done
	screen -S "Dst Master$input_save" -X stuff "c_save() \n"
	sleep 2
	pkill -f "Dst Master$input_save"
	echo -e "\033[33m[提示] 地面$input_save正在关闭请稍等 \033[0m"
	sleep 2
Main
}
function killCaves()
{
	echo -e "\033[33m[提示] [提示] 存档位 [1-5] \033[0m"
	read input_save
	echo -e "\033[33m[提示] 洞穴正在关闭请稍等 \033[0m"
		for((www=0;www<5;www++))
				do
		screen -S "Dst Caves$input_save" -X stuff "c_announce('服务器将在10秒内关闭，请停止跳世界等操作,否则会丢失个人存档，请耐心等待！')\n"
		sleep 2
	done
		screen -S "Dst Caves$input_save" -X stuff "c_save()\n"
		sleep 2
	pkill -f "Dst Caves$input_save"
	echo -e "\033[33m[提示] 洞穴$input_save正在关闭请稍等 \033[0m"
	sleep 2
Main
}
function killss()
{
	echo -e "\033[33m[提示] [提示] 存档位 [1-5] \033[0m"
	read input_save
	echo -e "\033[33m[提示] 服务器正在关闭请稍等 \033[0m"
	for((wwww=0;wwww<5;wwww++))
	do
		screen -S "Dst Master$input_save" -X stuff "c_announce('服务器将在10秒内关闭，请停止跳世界等操作,否则会丢失个人存档，请耐心等待！')\n"
		screen -S "Dst Caves$input_save" -X stuff "c_announce('服务器将在10秒内关闭，请停止跳世界等操作,否则会丢失个人存档，请耐心等待！')\n"
		sleep 2
	done
		screen -S "Dst Master$input_save" -X stuff "c_save() \n"
		sleep 2
		pkill -f "Dst Master$input_save"
		pkill -f "Dst Caves$input_save"
	echo -e "\033[33m[提示] 服务器$input_save正在关闭请稍等 \033[0m"
	sleep 2
Main
}
function killallscreen()
{
	killwh
	echo -e "\033[34m[提示] 服务器正在关闭已启动的服务器请稍等 \033[0m"
	cd "$MyDediServer"
	allsave=$(ls -l  | grep ^d | awk '{print $9}')
	for save in ${allsave}; do
      screen -ls | grep "Dst $save" | grep -v grep >>"$log_home" 2>&1
    if [ $? -eq 0 ]; then
        for((wwwww=0;wwwww<5;wwwww++));do
				screen -S "Dst $save" -X stuff "c_announce('服务器将在10秒内关闭，请停止跳世界等操作,否则会丢失个人存档，请耐心等待！')\n"
				done
        screen -S "Dst $save" -X stuff "c_shutdown(true)\n"
        echo -e "\033[33m 正在关闭$save\033[0m"
    fi
		sleep 2
	done
}
function killalls()
{
echo -e "\033[36m[提示] 强制关闭不会保存进度 \033[0m"
echo -e "\033[34m[提示] 服务器正在关闭请稍等 \033[0m"
screen -S "Dst Master1" -X stuff "c_announce('服主:所有世界服务器因改动或更新需要重启，预计耗时三分钟，给你带来的不便还请谅解!')\n"
killall screen
Main
}
function killprocess()
{
echo "============================================"
screen -ls
while :
do
echo -e "\033[33m [提示]:[1]地面 [2]洞穴 [3]地面+洞穴 [4]全部关闭  \033[0m"
echo -e "\033[33m [提示]:[5]强制关闭     [0]返回菜单 \033[0m"
echo
	read -p "请输入编号：" main2
		case $main2 in
			1)killMaster
			break;;
			2)killCaves
			break;;
			3)killss
			break;;
			4)killallscreen
			Main
			break;;
			5)killalls
			break;;
			0)Main
			break;;
		esac
done
}
function yilai()
{
	echo -e "\033[33m 正在更新依赖库，如果游戏无法正常启动或某些功能丢失使用次功能 \033[0m"
	Library
}
function lp()
{
  if [[ ! -f ${data_dir}/cluster_token.txt ]];then
    echo "没有检测到自定义令牌是否使用默认令牌（我的令牌）[1]是 [2]否"
    	while :
    	do
    	echo
    	read haha
    		case $haha in
    			1)
    			echo 'pds-g^KU_vCuBS8G6^yC3bjv8NbHUmjZeMcraxqpYyT0FykmOP·cZIEmEZSGwQ=' > ${MyDediServers}/cluster_token.txt
    			break;;
    	    2)
    	    echo "请输入/粘贴你的令牌"
          read linpai
            rm -rf ${data_dir}/cluster_token.txt
            echo "$linpai" >> ${data_dir}/cluster_token.txt
            rm -rf ${MyDediServers}/cluster_token.txt
            echo "$linpai" >> ${MyDediServers}/cluster_token.txt
          break;;
    		esac
    done
  elif [[ -f ${data_dir}/cluster_token.txt ]];then
    cat "${data_dir}/cluster_token.txt"
    echo "检测到自定义令牌是否更改自定义令牌[1]是 [2]否"
      while :
      do
      echo
      read haha2
        case $haha2 in
          1)
            echo "请输入/粘贴你的令牌"
            read linpa2
            rm -rf ${data_dir}/cluster_token.txt
            echo "$linpa2" >> ${data_dir}/cluster_token.txt
            rm -rf ${MyDediServers}/cluster_token.txt
            echo "$linpa2" >> ${MyDediServers}/cluster_token.txt
            break;;
          2)
            cp ${data_dir}/cluster_token.txt ${MyDediServers}/cluster_token.txt
            break;;
        esac
    done
  fi
}
#function lp()
#{
#	echo -e "\033[33m 是否更改令牌(默认是我的令牌) [1]是 [2] 否 \033[0m"
#	while :
#	do
#	echo
#	read haha
#		case $haha in
#			1)
#			read linpai
#				echo "$linpai" > cluster_token.txt
#			break;;
#			2)
#			echo 'pds-g^KU_vCuBS8G6^yC3bjv8NbHUmjZeMcraxqpYyT0FykmOP·cZIEmEZSGwQ=' > cluster_token.txt
#			break;;
#		esac
#done
#}
function Masterleve()
{
	  cat >leveldataoverride.lua <<-EOF
return {
  desc="标准《饥荒》体验。",
  hideminimap=false,
  id="SURVIVAL_TOGETHER",
  location="forest",
  max_playlist_position=999,
  min_playlist_position=0,
  name="标准森林",
  numrandom_set_pieces=4,
  override_level_string=false,
  overrides={
    alternatehunt="default",
    angrybees="default",
    antliontribute="default",
    autumn="default",
    bats_setting="default",
    bearger="default",
    beefalo="default",
    beefaloheat="default",
    beequeen="default",
    bees="default",
    bees_setting="default",
    berrybush="default",
    birds="default",
    boons="default",
    branching="default",
    brightmarecreatures="default",
    bunnymen_setting="default",
    butterfly="default",
    buzzard="default",
    cactus="default",
    carrot="default",
    carrots_regrowth="default",
    catcoon="default",
    catcoons="default",
    chess="default",
    cookiecutters="default",
    crabking="default",
    crow_carnival="default",
    day="default",
    deciduousmonster="default",
    deciduoustree_regrowth="default",
    deerclops="default",
    dragonfly="default",
    dropeverythingondespawn="default",
    evergreen_regrowth="default",
    extrastartingitems="default",
    eyeofterror="default",
    fishschools="default",
    flint="default",
    flowers="default",
    flowers_regrowth="default",
    frograin="default",
    frogs="default",
    fruitfly="default",
    gnarwail="default",
    goosemoose="default",
    grass="default",
    grassgekkos="default",
    hallowed_nights="default",
    has_ocean=true,
    hound_mounds="default",
    houndmound="default",
    hounds="default",
    hunt="default",
    keep_disconnected_tiles=true,
    klaus="default",
    krampus="default",
    layout_mode="LinkNodesByKeys",
    liefs="default",
    lightning="default",
    lightninggoat="default",
    loop="default",
    lureplants="default",
    malbatross="default",
    marshbush="default",
    merm="default",
    merms="default",
    meteorshowers="default",
    meteorspawner="default",
    moles="default",
    moles_setting="default",
    moon_berrybush="default",
    moon_bullkelp="default",
    moon_carrot="default",
    moon_fissure="default",
    moon_fruitdragon="default",
    moon_hotspring="default",
    moon_rock="default",
    moon_sapling="default",
    moon_spider="default",
    moon_spiders="default",
    moon_starfish="default",
    moon_tree="default",
    moon_tree_regrowth="default",
    mosquitos="default",
    mushroom="default",
    mutated_hounds="default",
    no_joining_islands=true,
    no_wormholes_to_disconnected_tiles=true,
    ocean_bullkelp="default",
    ocean_seastack="ocean_default",
    ocean_shoal="default",
    ocean_waterplant="ocean_default",
    ocean_wobsterden="default",
    penguins="default",
    penguins_moon="default",
    perd="default",
    petrification="default",
    pigs="default",
    pigs_setting="default",
    ponds="default",
    prefabswaps_start="default",
    rabbits="default",
    rabbits_setting="default",
    reeds="default",
    regrowth="default",
    roads="default",
    rock="default",
    rock_ice="default",
    saltstack_regrowth="default",
    sapling="default",
    season_start="default",
    seasonalstartingitems="default",
    shadowcreatures="default",
    sharks="default",
    spawnprotection="default",
    specialevent="default",
    spider_warriors="default",
    spiderqueen="default",
    spiders="default",
    spiders_setting="default",
    spring="default",
    squid="default",
    start_location="default",
    summer="default",
    summerhounds="default",
    tallbirds="default",
    task_set="default",
    tentacles="default",
    terrariumchest="default",
    touchstone="default",
    trees="default",
    tumbleweed="default",
    twiggytrees_regrowth="default",
    walrus="default",
    walrus_setting="default",
    wasps="default",
    weather="default",
    wildfires="default",
    winter="default",
    winterhounds="default",
    winters_feast="default",
    wobsters="default",
    world_size="default",
    wormhole_prefab="wormhole",
    year_of_the_beefalo="default",
    year_of_the_carrat="default",
    year_of_the_catcoon="default",
    year_of_the_gobbler="default",
    year_of_the_pig="default",
    year_of_the_varg="default"
  },
  random_set_pieces={
    "Sculptures_2",
    "Sculptures_3",
    "Sculptures_4",
    "Sculptures_5",
    "Chessy_1",
    "Chessy_2",
    "Chessy_3",
    "Chessy_4",
    "Chessy_5",
    "Chessy_6",
    "Maxwell1",
    "Maxwell2",
    "Maxwell3",
    "Maxwell4",
    "Maxwell6",
    "Maxwell7",
    "Warzone_1",
    "Warzone_2",
    "Warzone_3"
  },
  required_prefabs={ "multiplayer_portal" },
  required_setpieces={ "Sculptures_1", "Maxwell5" },
  settings_desc="标准《饥荒》体验。",
  settings_id="SURVIVAL_TOGETHER",
  settings_name="标准森林",
  substitutes={  },
  version=4,
  worldgen_desc="标准《饥荒》体验。",
  worldgen_id="SURVIVAL_TOGETHER",
  worldgen_name="标准森林"
}
EOF
}
function Cavesleve()
{
	  cat >leveldataoverride.lua <<-EOF
return {
  background_node_range={ 0, 1 },
  desc="探查洞穴…… 一起！",
  hideminimap=false,
  id="DST_CAVE",
  location="cave",
  max_playlist_position=999,
  min_playlist_position=0,
  name="洞穴",
  numrandom_set_pieces=0,
  override_level_string=false,
  overrides={
    atriumgate="default",
    banana="default",
    bats="default",
    bats_setting="default",
    beefaloheat="default",
    berrybush="default",
    boons="default",
    branching="default",
    brightmarecreatures="default",
    bunnymen="default",
    bunnymen_setting="default",
    cave_ponds="default",
    cave_spiders="default",
    cavelight="default",
    chess="default",
    crow_carnival="default",
    day="default",
    dropeverythingondespawn="default",
    dustmoths="default",
    earthquakes="default",
    extrastartingitems="default",
    fern="default",
    fissure="default",
    flint="default",
    flower_cave="default",
    flower_cave_regrowth="default",
    fruitfly="default",
    grass="default",
    grassgekkos="default",
    hallowed_nights="default",
    krampus="default",
    layout_mode="RestrictNodesByKey",
    lichen="default",
    liefs="default",
    lightflier_flower_regrowth="default",
    lightfliers="default",
    loop="default",
    marshbush="default",
    merms="default",
    molebats="default",
    moles_setting="default",
    monkey="default",
    monkey_setting="default",
    mushgnome="default",
    mushroom="default",
    mushtree="default",
    mushtree_moon_regrowth="default",
    mushtree_regrowth="default",
    nightmarecreatures="default",
    pigs_setting="default",
    prefabswaps_start="default",
    reeds="default",
    regrowth="default",
    roads="never",
    rock="default",
    rocky="default",
    rocky_setting="default",
    sapling="default",
    season_start="default",
    seasonalstartingitems="default",
    shadowcreatures="default",
    slurper="default",
    slurtles="default",
    slurtles_setting="default",
    snurtles="default",
    spawnprotection="default",
    specialevent="default",
    spider_dropper="default",
    spider_hider="default",
    spider_spitter="default",
    spider_warriors="default",
    spiderqueen="default",
    spiders="default",
    spiders_setting="default",
    start_location="caves",
    task_set="cave_default",
    tentacles="default",
    toadstool="default",
    touchstone="default",
    trees="default",
    weather="default",
    winters_feast="default",
    world_size="default",
    wormattacks="default",
    wormhole_prefab="tentacle_pillar",
    wormlights="default",
    worms="default",
    year_of_the_beefalo="default",
    year_of_the_carrat="default",
    year_of_the_catcoon="default",
    year_of_the_gobbler="default",
    year_of_the_pig="default",
    year_of_the_varg="default"
  },
  required_prefabs={ "multiplayer_portal" },
  settings_desc="探查洞穴…… 一起！",
  settings_id="DST_CAVE",
  settings_name="洞穴",
  substitutes={  },
  version=4,
  worldgen_desc="探查洞穴…… 一起！",
  worldgen_id="DST_CAVE",
  worldgen_name="洞穴"
}
EOF

}
function New_Caves()
{
	let Cavess=$Cavess+1
	cd $HOME
	if [[ ! -d ./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess ]];then
		mkdir -p ./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess
		echo 'return {  }' >> "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess/modoverrides.lua"
	fi
	echo -e "\033[36m 洞穴$Cavess已创建 \033[0m"
	while :
		do
	echo -e "\033[36m 这是一个：[1]主世界 [2] 附从世界 \033[0m"
	echo
	read gaga
		case $gaga in
			1)
			cd $HOME
echo '[NETWORK]
server_port = 10999


[SHARD]
is_master = true
name = 初始世界
id = 1


[ACCOUNT]
encode_user_path = false


[STEAM]
master_server_port = 27000
authentication_port = 8700
' >> "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess/server.ini"
cd $HOME
cd "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess"
Cavesleve
			break;;
			2)
			cd $HOME
echo "[NETWORK]
server_port = $server_portss


[SHARD]
is_master = false
name = 洞穴$Cavess
id = $savell


[ACCOUNT]
encode_user_path = false


[STEAM]
master_server_port = "$bhID"
authentication_port = "$bhID"
" >> "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess/server.ini"
cd $HOME
cd "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess"
Cavesleve
			break;;
		esac
done
}
function New_Master()
{
	let Masters=$Masters+1
	cd $HOME
	if [[ ! -d ./.klei/DoNotStarveTogether/MyDediServer/Master$Masters ]];then
		mkdir -p ./.klei/DoNotStarveTogether/MyDediServer/Master$Masters
		echo 'return {  }' >> "./.klei/DoNotStarveTogether/MyDediServer/Master$Masters/modoverrides.lua"
	fi
	echo -e "\033[36m 地面$Masters已创建 \033[0m"
	while :
		do
	echo -e "\033[36m 这是一个：[1]主世界 [2] 附从世界 \033[0m"
	echo
	read gaga
		case $gaga in
			1)
			cd $HOME
echo '[NETWORK]
server_port = 10999


[SHARD]
is_master = true
name = 初始世界
id = 1


[ACCOUNT]
encode_user_path = false


[STEAM]
master_server_port = 27000
authentication_port = 8700
' >> "./.klei/DoNotStarveTogether/MyDediServer/Master$Masters/server.ini"
cd "$MyDediServers/Master$Masters"
Masterleve
			break;;
			2)
			cd $HOME
echo "[NETWORK]
server_port = $server_portss


[SHARD]
is_master = false
name = 地面$Masters
id = $savell


[ACCOUNT]
encode_user_path = false


[STEAM]
master_server_port = "$bhID"
authentication_port = "$bhID"
" >> "./.klei/DoNotStarveTogether/MyDediServer/Master$Masters/server.ini"
cd "./.klei/DoNotStarveTogether/MyDediServer/Master$Masters"
Masterleve
			break;;
		esac
done
}
function haCaves()
{
	let Cavess=1
	cd $HOME
	if [[ ! -d $MyDediServers/Caves$Cavess ]];then
		mkdir -p ./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess
		echo 'return {  }' >> "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess/modoverrides.lua"
	fi
	cd $HOME
echo "[NETWORK]
server_port = 19998


[SHARD]
is_master = false
name = 洞穴$Cavess
id = 2


[ACCOUNT]
encode_user_path = false


[STEAM]
master_server_port = 2
authentication_port = 2
" >> "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess/server.ini"
cd $HOME
cd "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess"
Cavesleve
	echo -e "\033[36m 洞穴$Cavess已创建 \033[0m"
	sleep 2
}
function GameCaves()
{
		let Cavess=$Cavess+1
	cd $HOME
	if [[ ! -d $MyDediServers/Caves$Cavess ]];then
		mkdir -p ./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess
		echo 'return {  }' >> "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess/modoverrides.lua"
	fi
		cd $HOME
echo '[NETWORK]
server_port = 10999


[SHARD]
is_master = true
name = 初始世界
id = 1


[ACCOUNT]
encode_user_path = false


[STEAM]
master_server_port = 27000
authentication_port = 8700
' >> "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess/server.ini"
cd $HOME
cd "./.klei/DoNotStarveTogether/MyDediServer/Caves$Cavess"
Cavesleve
	echo -e "\033[36m 洞穴$Cavess已创建 \033[0m"
	sleep 2
}
function GameMaster()
{
	let Masters=$Masters+1
	cd $HOME
	if [[ ! -d $MyDediServers/Master$Masters ]];then
		mkdir -p ./.klei/DoNotStarveTogether/MyDediServer/Master$Masters
		echo 'return {  }' >> "./.klei/DoNotStarveTogether/MyDediServer/Master$Masters/modoverrides.lua"
	fi
		cd $HOME
echo '[NETWORK]
server_port = 10999


[SHARD]
is_master = true
name = 初始世界
id = 1


[ACCOUNT]
encode_user_path = false


[STEAM]
master_server_port = 27000
authentication_port = 8700
' >> "./.klei/DoNotStarveTogether/MyDediServer/Master$Masters/server.ini"
cd $HOME
cd "./.klei/DoNotStarveTogether/MyDediServer/Master$Masters"
Masterleve
	echo -e "\033[36m 地面$Masters已创建 \033[0m"
	sleep 2
}
function onesave()
{
	room_set_up
	lp
	echo -e "\033[33m 请选择要添加的世界[1]地面 [2]洞穴 [0]完成\033[0m"
	while :
	do
	echo
	read haha1
		case $haha1 in
			1)
			GameMaster
			break;;
			2)
			GameCaves
			break;;
			0)Main
			break;;
		esac
done
	encodes
Main
}
function Normal_world()
{
#	room_set_up
#	lp
	GameMaster
	haCaves
	encodes
	Main
}
function Reforgedworldroom()
{
  cat >cluster.ini <<-EOF
    steam_group_id =
    steam_group_admins = false
    steam_group_only = false

    [GAMEPLAY]
    game_mode = lavaarena
    pause_when_empty = true
    vote_enabled = true
    pvp = false
    max_players = 6

    [NETWORK]
    cluster_name = 由哉亚创建
    cluster_description = 由哉亚创建
    cluster_intention = cooperative
    cluster_language = zh
    whitelist_slots = 0
    idle_timeout = 0
    cluster_password =
    lan_only_cluster = false
    offline_cluster = false
    autosaver_enabled = true
    tick_rate = 15

    [MISC]
    max_snapshots = 20
    console_enabled = true

    [SHARD]
    master_ip = 127.0.0.1
    shard_enabled = true
    bind_ip = 0.0.0.0
    master_port = 10888
    cluster_key = Ariwori
EOF
}
function Reforgedleve()
{
  	cd $HOME
  	if [[ ! -d $MyDediServers/Master1 ]];then
  		mkdir -p ./.klei/DoNotStarveTogether/MyDediServer/Master1
  	fi
    cd ./.klei/DoNotStarveTogether/MyDediServer/Master1
  	cat >leveldataoverride.lua <<-EOF
return {
  ["background_node_range"]={ 0, 1 },
  ["desc"]="你敢去熔炉里证明你自己的实力吗？",
  ["hideminimap"]=false,
  id="LAVAARENA",
  ["location"]="lavaarena",
  ["max_playlist_position"]=999,
  ["min_playlist_position"]=0,
  ["name"]="熔炉",
  ["numrandom_set_pieces"]=0,
  ["override_level_string"]=false,
  ["overrides"]={
    ["autumn"]="default",
    ["beefaloheat"]="default",
    ["boons"]="never",
    ["brightmarecreatures"]="default",
    ["crow_carnival"]="default",
    ["day"]="default",
    ["dropeverythingondespawn"]="default",
    ["extrastartingitems"]="default",
    ["hallowed_nights"]="default",
    ["keep_disconnected_tiles"]=true,
    ["krampus"]="default",
    ["layout_mode"]="RestrictNodesByKey",
    ["no_joining_islands"]=true,
    ["no_wormholes_to_disconnected_tiles"]=true,
    ["poi"]="never",
    ["protected"]="never",
    ["roads"]="never",
    ["season_start"]="default",
    ["seasonalstartingitems"]="default",
    ["shadowcreatures"]="default",
    ["spawnprotection"]="default",
    ["specialevent"]="default",
    ["spring"]="default",
    ["start_location"]="lavaarena",
    ["summer"]="default",
    ["task_set"]="lavaarena_taskset",
    ["touchstone"]="never",
    ["traps"]="never",
    ["winter"]="default",
    ["winters_feast"]="default",
    ["world_size"]="small",
    ["year_of_the_beefalo"]="default",
    ["year_of_the_carrat"]="default",
    ["year_of_the_catcoon"]="default",
    ["year_of_the_gobbler"]="default",
    ["year_of_the_pig"]="default",
    ["year_of_the_varg"]="default"
  },
  ["required_prefabs"]={ "lavaarena_portal" },
  ["settings_desc"]="你敢去熔炉里证明你自己的实力吗？",
  ["settings_id"]="LAVAARENA",
  ["settings_name"]="熔炉",
  ["substitutes"]={  },
  ["version"]=2,
  ["worldgen_desc"]="你敢去熔炉里证明你自己的实力吗？",
  ["worldgen_id"]="LAVAARENA",
  ["worldgen_name"]="熔炉"
}
EOF
}
function Reforgeddk() {
    cd $HOME
    echo '[NETWORK]
    server_port = 10999


    [SHARD]
    is_master = true
    name = 熔炉世界
    id = 1


    [ACCOUNT]
    encode_user_path = false


    [STEAM]
    master_server_port = 1
    authentication_port = 1
    ' >> "./.klei/DoNotStarveTogether/MyDediServer/Master1/server.ini"
}
function Reforgedmod()
{
  cat >modoverrides.lua <<-EOF
return {
 ["workshop-1938752683"]={
   ["configuration_options"]={
     ["ADJUST_FILTER"]=false,
     ["BATTLESTANDARD_EFFICIENCY"]=1,
     ["COMMAND_SPAM_BAN_TIME"]=10,
     ["DAMAGE_NUMBER_FONT_SIZE"]=32,
     ["DAMAGE_NUMBER_HEIGHT"]=40,
     ["DAMAGE_NUMBER_OPTIONS"]="default",
     ["DAMAGE_NUMBER_PLAYERS"]=false,
     ["DEBUG"]=false,
     ["DEFAULT_FILTER"]=1,
     ["DEFAULT_LOBBY_TAB"]="news",
     ["DEFAULT_ROTATION"]=false,
     ["DIFFICULTY"]="normal",
     ["DISPLAY_COLORED_STATS"]=true,
     ["DISPLAY_TARGET_BADGE"]=true,
     ["DISPLAY_TEAMMATES_DEBUFFS"]=false,
     ["Damage Number Options"]=0,
     ["Detailed Summary Options"]=0,
     ["EVENT_TRACKING"]=true,
     ["FORCE_START_DELAY_TIME"]=30,
     ["FRIENDLY_FIRE"]=false,
     ["GAMETYPE"]="forge",
     ["GIFT_SIDE"]="right",
     ["Gameplay Settings"]=0,
     ["HIDE_INDICATORS"]=true,
     ["JOINABLE_MIDMATCH"]=true,
     ["LOBBY_GEAR"]=true,
     ["Lobby Options"]=0,
     ["MAX_MESSAGES"]=100,
     ["MOB_ATTACK_RATE"]=1,
     ["MOB_DAMAGE_DEALT"]=1,
     ["MOB_DAMAGE_TAKEN"]=1,
     ["MOB_DUPLICATOR"]=1,
     ["MOB_HEALTH"]=1,
     ["MOB_SIZE"]=1,
     ["MOB_SPEED"]=1,
     ["MODE"]="reforged",
     ["Mutators"]=0,
     ["NO_HUD"]=false,
     ["NO_REVIVES"]=false,
     ["NO_SLEEP"]=false,
     ["ONLY_SHOW_NONZERO_STATS"]=true,
     ["Other"]=0,
     ["PING_KEYBIND"]="KEY_R",
     ["PING_TRANSPARENCY"]=100,
     ["PLAYER_DEBUFF_DISPLAY"]="mini",
     ["Player HUD Options"]=0,
     ["RESERVE_SLOTS"]=true,
     ["ROTATION"]=0,
     ["SANDBOX"]=false,
     ["SERVER_ACHIEVEMENTS"]=false,
     ["SERVER_LEVEL"]=false,
     ["SHOW_CHAT_ICON"]=false,
     ["SPECTATORS_ONLY"]=true,
     ["SPECTATOR_ON_DEATH"]=false,
     ["VOTE_FORCE_START"]=true,
     ["VOTE_GAME_SETTINGS"]=true,
     ["VOTE_KICK"]=true,
     ["Visual Options"]=0,
     ["Vote"]=0,
     ["WAVESET"]="swineclops"
   },
   ["enabled"]=true
 }
 }
EOF
}
function Reforgedworld1()
{
    cd $MyDediServers
    Reforgedworldroom
    room_set_up
	  lp
	  Reforgedleve
    Reforgedmod
    Reforgeddk
    encodes
    Main
}
#判断一下有没有创建存档有的话提示是否要创建
function Create_warning()
{
	cd $MyDediServers
	allsave=$(ls -l |grep "^d"|wc -l)
#	echo $allsave

}
#1406行
function xuanze()
{
	echo -e "\033[33m 请选择[1]单层世界 [2]正常世界 [3]多层世界 [4]熔炉
	[0]完成\033[0m"
	while :
	do
	echo
	read haha1
		case $haha1 in
			1)
			onesave
			break;;
			2)
			Normal_world
			break;;
			3)New_save
			break;;
			4)Reforgedworld1
			break;;
			0)
			Main
			break;;
		esac
done
}
function New_save()
{
	let Masters=0
	let Cavess=0
	room_set_up
	lp
	haha
	encodes
	Main
}
function haha()
{
	echo -e "\033[33m 请选择要添加的世界[1]地面 [2]洞穴 [0]完成\033[0m"
	while :
	do
	let savell=$savell+1
	let bhID=$bhID+1
	let server_ports=20000
	let server_portss=$server_ports-$savell
	echo
	read haha1
		case $haha1 in
			1)
			New_Master
			haha
			break;;
			2)
			New_Caves
			haha
			break;;
			0)
			break;;
		esac
done
}
function announce()
{
  while (true)
  do
    clear
    echo -e "\e[33m提示：没有开启的档无法发送,按住ctrl+c即可退出公告\e[0m"
	  echo -e "\e[34m请输入你要发送的公告内容，按下回车键发送：\e[0m"
    read an
    screen -S "Dst Master1" -X stuff "c_announce('$an')\n"
    sleep 1
  done
}
function openwh()
{
	screen -r "自动维护"
}
function openServer()
{
echo "============================================"
screen -ls
while :
do
echo -e "\033[33m [提示]:按住ctrl再按住a全部松开再按d键返回 \033[0m"
echo -e "\033[33m [提示]:[1]地面 [2]洞穴 [3]手动进入 [4]自动维护 \033[0m"
echo -e "\033[33m        [5]公告 [0]返回 \033[0m"
echo
	read -p "请输入编号：" main2
		case $main2 in
			1)
			echo -e "\033[36m [提示] 地面 [1-5] \033[0m"
			cd $HOME
			read num
			screen -r "Dst Master$num"
			break;;
			2)
			echo -e "\032[36m [提示] 洞穴 [1-5] \033[0m"
			cd $HOME
			read num1
			screen -r "Dst Caves$num1"
			break;;
			3)
			echo -e "\033[36m 输入：进程前的pid，如（7788.地面 1）输入7788   回车进入该窗口 \033[0m"
			echo -e "\033[36m 输入：进入后想退出窗口请按ctrl+a+d \033[0m"
			read pid1
			screen -r $pid1
			break;;
			4)openwh
			break;;
			5)announce
			break;;
			0)Main
			break;;
		esac
done
Main
}
function congzhiMaster()
{
	echo -e "\033[34m[提示] 地面 [1-5]\033[0m"
	read input_save
	cd $HOME
	rm -r ./.klei/DoNotStarveTogether/MyDediServer/Master$input_save/save
	Main
}
function congzhiCaves()
{
	echo -e "\033[34m[提示] 洞穴 [1-5]\033[0m"
	read input_save1
	cd $HOME
	rm -r ./.klei/DoNotStarveTogether/MyDediServer/Caves$input_save1/save
	Main
}
function congzhisj()
{
	echo -e "\033[34m[提示] 存档位 [1-5]\033[0m"
	read input_save3
	cd $HOME
	rm -r ./.klei/DoNotStarveTogether/MyDediServer/Master$input_save3/save
	rm -r ./.klei/DoNotStarveTogether/MyDediServer/Caves$input_save3/save
	Main
}
function congzhiall()
{
cd $HOME
cd ".klei/DoNotStarveTogether/MyDediServer"
allsave=$(ls -l  | grep ^d | awk '{print $9}')
	for save in ${allsave}; do
	cd $HOME
	screen -x -S "Dst $save" -p 0 -X stuff "c_shutdown(true)"
	screen -x -S "Dst $save" -p 0 -X stuff $'\n'
	if [ -d ./.klei/DoNotStarveTogether/MyDediServer/$save/save ]
		then
	rm -r ./.klei/DoNotStarveTogether/MyDediServer/$save/save
	fi
	done
	echo -e "\033[33m 重置成功\033[0m"
}
function chongzhi()
{
	echo -e "\033[36m [提示]:请确定是否重置次操作不可逆转，建议先备份\033[0m"
	while :
		do
	echo -e "\033[33m [提示]:重置 [1.地面] [2.洞穴] [3.地面+洞穴] [4.一键重置] [0.返回]\033[0m"
	read -p "请输入编号：" input_mode
	cd $HOME
	case $input_mode in
		1)
			congzhiMaster;;
		2)
			congzhiCaves;;
		3)
			congzhisj;;
		4)
			congzhiall;;
		0)
			Main;;
		esac
done
	Main
}
function retreated()
{
	while (true)
	do
	clear
	echo -e "\e[33m [提示]:请输入输入数字类如[1-5],没有开启的档无法回档\e[0m"
    echo -e "\e[33m [提示]:输入结束或返回请输入数字[0]\e[0m"
    read -p "请输入编号：" Retreated1
	if [ $Retreated1 -eq 0 ]; then
		break
	else
		txt="即将恢复到第$Retreated1天前，请耐心等待"
		echo -e "\033[36m $txt \033[0m"
		screen -S "Dst Master1" -X stuff "c_announce('$txt')\n"
		sleep 3
		screen -S "Dst Master1" -X stuff "c_rollback('$Retreated1')\n"
		sleep 1
	fi
	done
	Main
}
function beifeng()
{
	cd $HOME
	if [ -d ~/.klei/DoNotStarveTogether ]
	then
	cd .klei/DoNotStarveTogether
	zip -r Dst$time2.zip MyDediServer
	echo -e "\033[33m[提示] 存档 DoNotStarveTogether$time2 已备份\033[0m"
	sleep 2
	fi
	Main
}
function huifu()
{
	cd $HOME
	if [ -d .klei/DoNotStarveTogether ]
	then
	cd .klei/DoNotStarveTogether
	txt3=$(ls | grep 'zip')
	arraya=('' $txt3)
	for((l=1;l<${#arraya[@]};l++))
		do
		echo " [ $l ]"${arraya[$l]}
	done
		echo -e "\033[36m "请根据时间选择要恢复的备份,输入[0]返回" \033[0m"
		read -p "请输入编号：" bf
		if [  $bf -eq 0 ]; then
			Main
		else
			if [ -d MyDediServer ]
			then
				rm -r MyDediServer
			else
				echo "存档已经删除直接恢复"
			fi
			unzip ${arraya[$bf]}
			echo -e "\033[33m[提示] 存档 已恢复\033[0m"
			sleep 2
			fi
		fi
Main
}
function wup()
{
#echo "请输入要给予玩家的物品"
#read WPS
while :
do
echo -e "\033[34m"[提示]请选择要给予玩家的物品" \033[0m"
echo -e "\033[34m"提示:[1.木头] [2.蜘蛛] [3.彩虹宝石]" \033[0m"
echo
	read main1
		case $main1 in
			1)WPS=log
			break;;
			2)WPS=spider
			break;;
			3)WPS=opalpreciousgem
			break;;
		esac
done
}
function shen()
{
	cd $HOME
	if [ ! -d ".klei/DoNotStarveTogether/MyDediServer/Master1/save/session" ];then
		echo -e "\033[36m 没有玩家进入或未开启存档 \033[0m"
		sleep 3
		Main
	else
		cd ".klei/DoNotStarveTogether/MyDediServer/Master1/save/session"
		for r in *; do
			cd $r
			break
			done
		allsave1=$(ls -l  | grep ^d | awk '{print $9}')
		for save in ${allsave1}; do
			echo " 玩家ID：$save"
		done
			echo " [提示]请手动输入玩家id,输入[0]返回"
			read -p " 请输入玩家id：" IDS
			wup
			echo "[提示]请输入数量"
			read -p " 请输入数量：" numa
			for((z=0;z<$numa;z++))
				do
				cd $HOME
				cd ".klei/DoNotStarveTogether/MyDediServer"
				allsave3=$(ls -l  | grep ^d | awk '{print $9}')
				for save3 in ${allsave3}; do
				screen -S "Dst $save3" -X stuff "
				for k, v in pairs(AllPlayers) do if v and v.userid == '$IDS'  then local item = SpawnPrefab(\"$WPS\") if item then item.Transform:SetPosition(v.Transform:GetWorldPosition()) end end end \n"
				 echo -e "\034[34m[提示] 已成功给予"Dst $save3"世界$IDS $numa个 $WPS \033[0m"
				done
			done
	fi
}
function jiushu()
{
cd $HOME
if [ ! -d ".klei/DoNotStarveTogether/MyDediServer/Master1/save/session" ];then
	cd ".klei/DoNotStarveTogether/MyDediServer/Master1/save/session"
fi
for r in *; do
	cd $r
	break
done
		allsave4=$(ls -l  | grep ^d | awk '{print $9}')
		for save4 in ${allsave4}; do
			echo "玩家ID：$save4"
		done
	echo "[提示] 只有和主世界在同一服务器的的情况才能使用"
echo -e "\033[33m 请输入玩家克雷ID \033[0m"
read IDS3
echo -e "\033[33m [提示] 请选择存档 \033[0m"
read cundang2
echo -e "\033[33m 提示 [1.地面 ] [2.洞穴 ] \033[0m"
read shijiea3
	case $shijiea3 in
		1)
			shijied=Master;;
		2)
			shijied=Caves;;
	esac
cd $HOME
cd ".klei/DoNotStarveTogether/MyDediServer/"$shijied""$cundang2"/save/session"
for za in  *; do
	cd $za
	break
done
cd $HOME
cp -a $MyDediServers/Master1/save/session/$r/$IDS3 $MyDediServers"$shijied""$cundang2"/save/session/$za/
echo "已成功"
Main
}
function encodes()
{
while :
do
echo "如需要玩家存档对应文件夹为玩家KleiID,以下请选否"
echo "编码玩家存档路径：[1]是 [2]否 [0]返回菜单"
echo
	read main7
		case $main7 in
			1)
			cd "$MyDediServers"
				allsave5=$(ls -l  | grep ^d | awk '{print $9}')
				for save5 in ${allsave5}; do
			cd $HOME
			if cat "$MyDediServers/$save5/server.ini" | grep  "encode_user_path"
					then
					cd "$MyDediServers/$save5"
					sed -i '/encode_user_path/d' server.ini
					echo "encode_user_path = true" >> server.ini
				else
					echo "没有此存档"
			fi
			done
			echo "修改成功"
			sleep 2
			break;;
			2)
			cd "$MyDediServers"
				allsave6=$(ls -l  | grep ^d | awk '{print $9}')
				for save6 in ${allsave6}; do
			if cat "$MyDediServers/$save6/server.ini" | grep "encode_user_path"
					then
					cd "$MyDediServers/$save6"
					sed -i '/encode_user_path/d' server.ini
					echo "encode_user_path = false" >> server.ini
				else
					echo "没有此存档"
			fi
			done
			echo "修改成功"
			sleep 2
			break;;
			0)
			break;;
		esac
done
}
function cluster_name()
{
	echo 房间名称:${a}
	echo 请输入新的房间名称
	read room_name
	sed -i "s/cluster_name = ${a}/cluster_name = $room_name/g" cluster.ini
	room_set_up
}
function Room_introduction()
{
	echo 房间介绍:${b}
	echo 请输入新的房间介绍
	read Room_introductions
	sed -i "s/cluster_description = ${b}/cluster_description = $Room_introductions/g" cluster.ini
	room_set_up
}
function Game_style()
{
while :
do
echo 游戏风格:$txt6
echo 请选择游戏风格 [1] 休闲 [2] 合作 [3] 竞赛 [4] 疯狂
echo
	read main2
		case $main2 in
			1)WPSS=social
			break;;
			2)WPSS=cooperative
			break;;
			3)WPSS=competitive
			break;;
			4)WPSS=madness
			break;;
			*)
			echo 没有此选项请重新选择
		esac
done
	sed -i "s/${c}/$WPSS/g" cluster.ini
room_set_up
}
function Game_mode()
{
while :
do
echo 游戏模式:$txt
echo 请选择游戏模式 [1] 无尽 [2] 生存 [3] 荒野 [4] 熔炉 [5] 暴食
echo
	read game
		case $game in
			1)WPSS2=endless
			break;;
			2)WPSS2=survival
			break;;
			3)WPSS2=wilderness
			break;;
			4)WPSS2=lavaarena
			break;;
			5)WPSS2=quagmire
			break;;
			*)
			echo 没有此选项请重新选择
		esac
done
	sed -i "s/${d}/$WPSS2/g" cluster.ini
room_set_up
}
function Game_language()
{
while :
do
echo 游戏模式:$txt
echo 请选择游戏模式 [1] 中文 [2] 英文
echo
	read game1
		case $game1 in
			1)WPSS3=zh
			break;;
			2)WPSS3=en
			break;;
			*)
			echo 没有此选项请重新选择
		esac
done
	sed -i "s/${r}/$WPSS3/g" cluster.ini
room_set_up
}
function GameSteam_group()
{
while :
do
echo 无人暂停:$txt3
echo 请选择游戏模式 [1] 开启 [2] 关闭
echo
	read game2
		case $game2 in
			1)gamems=true
			break;;
			2)gamems=false
			break;;
			*)
			echo 没有此选项请重新选择
		esac
done
	sed -i "s/pause_when_empty = ${h}/pause_when_empty = $gamems/g" cluster.ini
room_set_up
}
function Game_vote()
{
while :
do
echo 投票:$txt4
echo 是否开启投票 [1] 开启 [2] 关闭
echo
	read game3
		case $game3 in
			1)vote=true
			break;;
			2)vote=false
			break;;
			*)
			echo 没有此选项请重新选择
		esac
done
	sed -i "s/vote_enabled = ${i}/vote_enabled = $vote/g" cluster.ini
room_set_up
}
function GamePVP()
{
while :
do
echo PVP竞争:$txt5
echo 是否开启PVP [1] 开启 [2] 关闭
echo
	read game4
		case $game4 in
			1)PVPs=true
			break;;
			2)PVPs=false
			break;;
			*)
			echo 没有此选项请重新选择
		esac
done
	sed -i "s/pvp = ${j}/pvp = $PVPs/g" cluster.ini
room_set_up
}
function steam_group_adminss()
{
while :
do
echo 群组官员设为管理员:$txt8
echo 群组官员是否设为管理员 [1] 开启 [2] 关闭
echo
	read steam_group_adminsss
		case $steam_group_adminsss in
			1)adminsss=true
			break;;
			2)adminsss=false
			break;;
			*)
			echo 没有此选项请重新选择
		esac
done
	sed -i "s/steam_group_admins = ${t}/steam_group_admins = $adminsss/g" cluster.ini
room_set_up
}
function steam_group_onlys()
{
	while :
	do
	echo 仅群组成员可进:$txt9
	echo 是否设为仅群组成员可进 [1] 开启 [2] 关闭
	echo
		read steam_group_onlyss
			case $steam_group_onlyss in
				1)steam_group_onlysss=true
				break;;
				2)steam_group_onlysss=false
				break;;
				*)
				echo 没有此选项请重新选择
			esac
	done
		sed -i "s/steam_group_only = ${u}/steam_group_only = $steam_group_onlysss/g" cluster.ini
	room_set_up
}
function steam_group_ids()
{
	echo 群组id:$txt10
	echo 请输入新的群组id
	read steam_group_idss
		sed -i "s/steam_group_id = ${s}/steam_group_id = $steam_group_idss/g" cluster.ini
	room_set_up
}
function Room_reservation()
{
echo 房间预留位置个数:${k}
echo 请输入新的预留位置个数
read game5
	sed -i "s/whitelist_slots = ${k}/whitelist_slots = $game5/g" cluster.ini
room_set_up
}
function Hanguptimeoutkickouttime()
{
echo 挂机超时踢出时间:${l}
echo 请输入新的时间
read game6
	sed -i "s/idle_timeout = ${l}/idle_timeout = $game6/g" cluster.ini
room_set_up
}
function Maximumarchivesnapshots()
{
echo 最大存档快照数:${m}
echo 请输入新的快照数
read game7
	sed -i "s/max_snapshots = ${m}/max_snapshots = $game7/g" cluster.ini
room_set_up
}
function Room_code()
{
echo 房间密码:${o}
echo 请输入新的房间密码
read game8
	sed -i "s/cluster_password = ${o}/cluster_password = $game8/g" cluster.ini
room_set_up
}
function Maxnumber_players()
{
echo 最大玩家人数:${n}
echo 请输入新的最大人数
read game9
	sed -i "s/max_players = ${n}/max_players = $game9/g" cluster.ini
room_set_up
}
function main_world_IP()
{
echo 主世界IP:${p}
echo 请输入新的IP
read game10
	sed -i "s/master_ip = ${p}/master_ip = $game10/g" cluster.ini
room_set_up
}
function New_room()
{
cd $HOME
if [[ ! -f "./.klei/DoNotStarveTogether/MyDediServer/cluster.ini" ]]; then
echo 'steam_group_id =
steam_group_admins = false
steam_group_only = false

[GAMEPLAY]
game_mode = endless
pause_when_empty = true
vote_enabled = true
pvp = false
max_players = 6

[NETWORK]
cluster_name = 由哉亚创建
cluster_description = 由哉亚创建
cluster_intention = cooperative
cluster_language = zh
whitelist_slots = 0
idle_timeout = 0
cluster_password =
lan_only_cluster = false
offline_cluster = false
autosaver_enabled = true
tick_rate = 15

[MISC]
max_snapshots = 20
console_enabled = true

[SHARD]
master_ip = 127.0.0.1
shard_enabled = true
bind_ip = 0.0.0.0
master_port = 10888
cluster_key = Ariwori
' >> ./.klei/DoNotStarveTogether/MyDediServer/cluster.ini
fi
}
function room_set_up()
{
New_room
cd "$MyDediServers"
clear
a=$(cat cluster.ini |grep -o "cluster_name = .*"| awk -F"= " '{print $2}'|head -n 1)
b=$(cat cluster.ini |grep -o "cluster_description = .*"| awk -F"= " '{print $2}'|head -n 1)
c=$(cat cluster.ini |grep -o "cluster_intention = .*"| awk -F"= " '{print $2}'|head -n 1)
d=$(cat cluster.ini |grep -o "game_mode = .*"| awk -F"= " '{print $2}'|head -n 1)
h=$(cat cluster.ini |grep -o "pause_when_empty = .*"| awk -F"= " '{print $2}'|head -n 1)
i=$(cat cluster.ini |grep -o "vote_enabled = .*"| awk -F"= " '{print $2}'|head -n 1)
j=$(cat cluster.ini |grep -o "pvp = .*"| awk -F"= " '{print $2}'|head -n 1)
k=$(cat cluster.ini |grep -o "whitelist_slots = .*"| awk -F"= " '{print $2}'|head -n 1)
l=$(cat cluster.ini |grep -o "idle_timeout = .*"| awk -F"= " '{print $2}'|head -n 1)
m=$(cat cluster.ini |grep -o "max_snapshots = .*"| awk -F"= " '{print $2}'|head -n 1)
n=$(cat cluster.ini |grep -o "max_players = .*"| awk -F"= " '{print $2}'|head -n 1)
o=$(cat cluster.ini |grep -o "cluster_password = .*"| awk -F"= " '{print $2}'|head -n 1)
p=$(cat cluster.ini |grep -o "master_ip = .*"| awk -F"= " '{print $2}'|head -n 1)
r=$(cat cluster.ini |grep -o "cluster_language = .*"| awk -F"= " '{print $2}'|head -n 1)
s=$(cat cluster.ini |grep -o "steam_group_id = .*"| awk -F"= " '{print $2}'|head -n 1)
t=$(cat cluster.ini |grep -o "steam_group_admins = .*"| awk -F"= " '{print $2}'|head -n 1)
u=$(cat cluster.ini |grep -o "steam_group_only = .*"| awk -F"= " '{print $2}'|head -n 1)
if [[ ${d} == endless ]];then
	txt="无尽"
elif [[ ${d} == survival ]];then
	txt="生存"
elif [[ ${d} == wilderness ]];then
	txt="荒野"
elif [[ ${d} == lavaarena ]];then
	txt="熔炉"
elif [[ ${d} == quagmire ]];then
	txt="暴食"
fi
if [[ ${c} == social ]];then
	txt6="休闲"
elif [[ ${c} == cooperative ]];then
	txt6="合作"
elif [[ ${c} == competitive ]];then
	txt6="竞赛"
elif [[ ${c} == madness ]];then
	txt6="疯狂"
fi
if [[ ${f} == true ]];then
	txt1="开启"
elif [[ ${f} == false ]];then
	txt1="关闭"
fi
if [[ ${g} == true ]];then
	txt2="开启"
elif [[ ${g} == false ]];then
	txt2="关闭"
fi
if [[ ${h} == true ]];then
	txt3="开启"
elif [[ ${h} == false ]];then
	txt3="关闭"
fi
if [[ ${i} == true ]];then
	txt4="开启"
elif [[ ${i} == false ]];then
	txt4="关闭"
fi
if [[ ${j} == true ]];then
	txt5="开启"
elif [[ ${j} == false ]];then
	txt5="关闭"
fi
if [[ ${r} == "zh" ]];then
	txt7="中文"
elif [[ ${r} == en ]];then
	txt7="英文"
fi
if [[ ${t} == true ]];then
	txt8="开启"
elif [[ ${t} == false ]];then
	txt8="关闭"
fi
if [[ ${u} == true ]];then
	txt9="开启"
elif [[ ${u} == false ]];then
	txt9="关闭"
fi
if [[ ${s} == "" ]];then
	txt10="无"
else
	txt10=${s}
fi
if [[ ${o} == "" ]];then
	txt11="无"
else
	txt11=${o}
fi
clear
echo [ 1]房间名称:${a}
echo [ 2]房间介绍:${b}
echo [ 3]游戏风格:$txt6
echo [ 4]游戏模式:$txt
echo [ 5]游戏语言:$txt7
echo [ 6]群组id:$txt10
echo [ 7]群组官员设为管理员:$txt8
echo [ 8]仅群组成员可进:$txt9
echo [ 9]无人暂停:$txt3
echo [10]投票:$txt4
echo [11]pvp竞技:$txt5
echo [12]房间预留位置个数:${k}
echo [13]挂机超时踢出时间:${l}
echo [14]最大存档快照数:${m}
echo [15]房间密码:$txt11
echo [16]玩家最大数量:${n}
echo "[17]主世界IP(多服务器必须修改此项):${p}"
while :
do
echo -e "\033[33m[提示] 选择你要更改的选项 [0]完成\033[0m"
echo
	read main1
		case $main1 in
			1)cluster_name
			break;;
			2)Room_introduction
			break;;
			3)Game_style
			break;;
			4)Game_mode
			break;;
			5)Game_language
			break;;
			6)steam_group_ids
			break;;
			7)steam_group_adminss
			break;;
			8)steam_group_onlys
			break;;
			9)GameSteam_group
			break;;
			10)Game_vote
			break;;
			11)GamePVP
			break;;
			12)Room_reservation
			break;;
			13)Hanguptimeoutkickouttime
			break;;
			14)Maximumarchivesnapshots
			break;;
			15)Room_code
			break;;
			16)Maxnumber_players
			break;;
			17)main_world_IP
			break;;
			0)
			break;;
		esac
done
}
function dkou()
{
		dko=$(cat server.ini |grep -o "id = .*"| awk -F"= " '{print $2}'|head -n 1)
		server_ports=$(cat server.ini |grep -o "server_port = .*"| awk -F"= " '{print $2}'|head -n 1)
		master_serves=$(cat server.ini |grep -o "master_server_port = .*"| awk -F"= " '{print $2}'|head -n 1)
		authentications=$(cat server.ini |grep -o "authentication_port = .*"| awk -F"= " '{print $2}'|head -n 1)
		echo -e "\033[36m现在端口ID为${dko}\033[0m"
		echo -e "\033[36m请输入修改的数字类如:1-5\033[0m"
		read dkid
		let $dkid
		let NUM=20000
		let NUM=20000-$dkid
		sed -i "s/id = ${dko}/id = $dkid/g" server.ini
		sed -i "s/server_port = ${server_ports}/server_port = $NUM/g" server.ini
		sed -i "s/master_server_port = ${master_serves}/master_server_port = $dkid/g" server.ini
		sed -i "s/authentication_port = ${authentications}/authentication_port = $dkid/g" server.ini
}
function Masterid()
{
	echo -e "\033[33m[提示] 存档位 [1-5]\033[0m"
	read input_save
	cd $MyDediServers/Master$input_save
	dkou
	Change_port
}
function Cavesid()
{
	echo -e "\033[33m[提示] 存档位 [1-5]\033[0m"
	read input_save
	cd $MyDediServers/Caves$input_save
	dkou
	Change_port
}
function Change_port()
{
	while :
	do
	cd "$MyDediServers"
	allsave=$(ls -l  | grep ^d | awk '{print $9}')
	for save in ${allsave}; do
		dko=$(cat $save/server.ini |grep -o "id = .*"| awk -F"= " '{print $2}'|head -n 1)
		echo -e "\033[36m 世界存档："$save" ID："$dko" \033[0m"
	done
	echo -e "\033[33m[提示] 选择世界 [1]地面 [2]洞穴 [0]返回\033[0m"
	read input_mode
		echo
			case $input_mode in
				1)
				Masterid
				break;;
				2)
				Cavesid
				break;;
				0)
				break
			esac
	done
}
function shezhi()
{
while :
do
echo -e "\033[33m [提示]:[1]房间设置 [2]编码玩家存档路径 [3]更改世界端口 [4]更改令牌 [0]返回\033[0m"
echo
	read -p "请输入编号：" shezhi1
		case $shezhi1 in
			1)room_set_up
			shezhi
			break;;
			2)encodes
			shezhi
			break;;
			3)Change_port
			shezhi
			break;;
	    4)lp
	    shezhi
	    break;;
			0)Main
			break;;
		esac
done
}
function shenchen()
{
  cd $HOME
  if [[ ! -f k.sh ]];then
  cat > k.sh <<-'EOF'
#!/bin/bash

DST_HOME="${HOME}/dst"
gamesPath="${DST_HOME}/bin"
ugc_directory="${DST_HOME}/ugc_mods"
dst_conf_basedir="${HOME}/.klei"
dst_conf_dirname="DoNotStarveTogether"
gamesFile="./dontstarve_dedicated_server_nullrenderer"
game="dst/mods/dedicated_server_mods_setup.lua"
MyDediServers="${HOME}/.klei/DoNotStarveTogether/MyDediServer"

gameupdates=true
modupdates=true
game_selfstart=true

function announce()
{
echo -e "\033[33m 向服务器发送公告 \033[0m"
cd $HOME
cd ".klei/DoNotStarveTogether/MyDediServer"
allsavee=$(ls -l  | grep ^d | awk '{print $9}')
for savee in ${allsavee}; do
  screen -ls |grep "Dst $savee" |grep -v grep
      if [ $? -eq 0 ];then
        for((wwww2=0;wwww2<5;wwww2++))
        do
        screen -S "Dst $savee" -X stuff "c_announce('服主：小伙伴们$savee世界因模组更新，将在10秒后关闭请记住房间号一会再进入，预计耗时三分钟，请耐心等待！')\n"
          sleep 2
        done
      fi
done
}
function announceupdate()
{
echo -e "\033[33m 向服务器发送公告 \033[0m"
cd $HOME
cd ".klei/DoNotStarveTogether/MyDediServer"
allsavees=$(ls -l  | grep ^d | awk '{print $9}')
for savees in ${allsavees}; do
  screen -ls |grep "Dst $savees" |grep -v grep
    if [ $? -eq 0 ];then
      for((wwww3=0;wwww3<5;wwww3++))
      do
      screen -S "Dst $savees" -X stuff "c_announce('服主：小伙伴们$savee世界因服务器要更新需要重启，将在10秒后关闭请记住房间号一会再进入，预计耗时三分钟，请耐心等待！')\n"
        sleep 2
      done
    fi
done
}
function qidongsave()
{
echo -e "\033[33m正在检测异常重启 \033[0m"
cd $HOME
cd ".klei/DoNotStarveTogether/MyDediServer"
allsave=$(ls -l  | grep ^d | awk '{print $9}')
for save in ${allsave}; do
screen -ls |grep "Dst $save" |grep -v grep
if [ $? -ne 0 ];then
cd $HOME
cd "$gamesPath"
screen -dmS "Dst $save" "$gamesFile" -skip_update_server_mods -ugc_directory ${ugc_directory} -persistent_storage_root ${dst_conf_basedir} -conf_dir ${dst_conf_dirname} -cluster MyDediServer -shard ${save}
echo -e "\033[33m检测异常重新启动$save\033[0m"
sleep 2
else
echo -e "\033[33m"Dst $save"世界正常继续检测\033[0m"
fi
done
}
function killallscreen()
{
	echo -e "\033[34m[提示] 服务器正在关闭已启动的服务器请稍等 \033[0m"
	cd "$MyDediServer"
	allsave=$(ls -l  | grep ^d | awk '{print $9}')
	for save in ${allsave}; do
      screen -ls | grep "Dst $save" | grep -v grep
    if [ $? -eq 0 ]; then
        for((wwwww=0;wwwww<5;wwwww++));do
				screen -S "Dst $save" -X stuff "c_announce('服务器将在10秒内关闭，请停止跳世界等操作,否则会丢失个人存档，请耐心等待！')\n"
				done
        screen -S "Dst $save" -X stuff "c_shutdown(true)\n"
        echo -e "\033[33m 正在关闭$save\033[0m"
    fi
		sleep 5
	done
}
function jiance()
{
cd $HOME
new_game_version=$(curl -s 'https://forums.kleientertainment.com/game-updates/dst/' | grep 'data-currentRelease' | cut -d '/' -f6 | cut -d '-' -f1 | sort -r | head -n 1 | tr -cd '[0-9]' )
cur_game_version=$(cat "${HOME}/dst/version.txt")
if [[ $cur_game_version != "" && $new_game_version != "" && $cur_game_version != $new_game_version ]]
then
echo "最新版本$new_game_version"
echo "本地版本$cur_game_version"
echo "游戏版本不一样开始更新"
announceupdate
sleep 10
echo -e "\033[34m开始关闭世界 \033[0m"
killallscreen
cd $HOME
cd ./steamcmd
./steamcmd.sh +force_install_dir "$dst_home" +login anonymous +app_update 343050 +quit
clear
echo "更新完毕开始启动"
qidongsave
else
echo "最新版本$new_game_version"
echo "本地版本$cur_game_version"
echo "没有游戏要更新正常运行"
fi
}

function xunhuan()
{
  sudo rm -rf /$HOME/.klei/DoNotStarveTogether/Download/Master1/server_log.txt
  cd $HOME
  cd "$gamesPath"
screen -dmS "更新" "$gamesFile" -only_update_server_mods -ugc_directory ${ugc_directory} -persistent_storage_root ${dst_conf_basedir} -conf_dir ${dst_conf_dirname} -cluster Download -shard Master1
  while :; do
    cd $HOME
    logs=$(cat ".klei/DoNotStarveTogether/Download/Master1/server_log.txt")
    if cat .klei/DoNotStarveTogether/Download/Master1/server_log.txt | grep "FinishDownloadingServerMods Complete!"; then
      clear
      echo -e "\033[33m 模组更新完毕\033[0m"
      break
    else
      echo -e "\033[33m $logs\033[0m"
      sleep 3
    fi
  done
  echo -e "\033[33m 正在检测是否有未下载/更新成功的模组\033[0m"
  if cat .klei/DoNotStarveTogether/Download/Master1/server_log.txt | grep "OnDownloadPublishedFile"; then
    echo -e "\033[33m检测到有模组为下载/更新成功再次更新\033[0m"
    xunhuan
  elif cat .klei/DoNotStarveTogether/Download/Master1/server_log.txt | grep "DownloadPublishedFile"; then
    echo -e "\033[33m检测到有模组为下载/更新成功再次更新\033[0m"
    xunhuan
  fi
}
function modupdate()
{
echo -e "\033[33m 开始检测模组更新\033[0m"
cd $HOME
cd ".klei/DoNotStarveTogether/MyDediServer"
allsav=$(ls -l  | grep ^d | awk '{print $9}')
for sav in ${allsav}; do
  cd $HOME
  modlog="./.klei/DoNotStarveTogether/MyDediServer/$sav/server_chat_log.txt"
  if cat "$modlog" | grep "is out of date and needs to be updated for new users to be able to join the server.";then
    sudo rm -rf /$HOME/.klei/DoNotStarveTogether/MyDediServer/$sav/server_chat_log.txt
  echo "检测到$sav世界新版本模组，开始更新！"
  announce
  sleep 10
  killallscreen
  xunhuan
  qidongsave
  else
  echo -e "\033[33m未检测到$sav世界新版本模组\033[0m"
  fi
done
}
while :
do
if [[ $gameupdates == "true" ]];then
jiance
sleep 10
fi
if [[ $game_selfstart == "true" ]];then
qidongsave
sleep 10
fi
if [[ $modupdates == "true" ]];then
modupdate
sleep 10
fi
sleep 10
done

EOF
fi
}
function Auto_update()
{
  screen -ls |grep "自动维护" |grep -v grep
  if [ $? -ne 0 ];then
    pkill -f 自动维护
    sleep 1
    cd ${HOME}
    screen -dmS "自动维护" "./zaiya.sh au"
    echo "附加功能已开启！"
  fi
}
function whh()
{
    while (true); do
      echo -e "\e[33m=====饥荒联机版独立服务器脚本拓展功能设置[Linux-Steam]=====\e[0m"
      echo -e "\e[92m    0. 保存设置重启拓展功能进程并返回主菜单\e[0m"
      echo -e "\e[92m    1. 周期性检查游戏进程是否意外退出，退出自动重启\e[0m"
      echo -e "\e[92m    2. 周期性备份当前开启的存档\e[0m"
      echo -e "\e[92m    3. 周期性检查游戏是否有更新，有则重启更新！\e[0m"
      echo -e "\e[92m    4. 周期性检查模组是否有更新，有则重启更新！\e[0m"
      echo -e "\e[35m涉及时间的设置单位均为分钟，只能输入整数，尽量不要小于五分钟。\e[0m"
      echo -e "\e[33m=====================================================================\e[0m"
      echo -e "\e[92m请输入命令代号：\e[0m\c"
      read efs
      case $efs in
      0)
        Auto_update
        break
        ;;
      1)
        parm="keepalive"
        ;;
      2)
        parm="backupcluster"
        ;;
      3)
        parm="gameupdate"
        ;;
      *)
        error "输入有误！！！"
        ;;
      esac
      efs_menu
    done
}
function efs_menu()
{
    while (true); do
      echo -e "\e[92m请选择设置项： 0.返回上一级  1.是否开启   2.时间周期  ：\e[0m\c"
      read sss
      case $sss in
      0)
        break
        ;;
      1)
        echo -e "\e[92m请选择： 1.开启   2.关闭  ：\e[0m\c"
        read isopen
        case $isopen in
        1)
          st="true"
          exchangesetting "$parm" "$st"
          ;;
        *)
          st="false"
          exchangesetting "$parm" "$st"
          ;;
        esac
        ;;
      2)
        echo -e "\e[92m请输入时间间隔[分钟、整数]：\e[0m\c"
        read dtime
        [[ $dtime == "" ]] && dtime=30
        exchangesetting "${parm}time" "$dtime"
        ;;
      *)
        error "输入有误！！！"
        ;;
      esac
    done
}
function ziwh()
{
  shenchen
		while :
		do
		echo -e "\033[33m [提示]: [1]启动 [2]关闭 [3]设置 [0]返回\033[0m"
		echo
			read -p "请输入编号：" main1
				case $main1 in
					1)qidong
					  ziwh
					break;;
					2)killwh
					  ziwh
					break;;
					3)whsz
					  ziwh
					break;;
					0)Main
					break;;
				esac
		done
}
function qidong()
{
	screen -ls |grep "自动维护" |grep -v grep
	if [ $? -ne 0 ];then
		cd $HOME
		chmod +x k.sh
		screen -dmS "自动维护" "./k.sh"
		echo -e "\033[33m " 自动维护成功启动 "\033[0m"
		sleep 1
	else
		echo -e "\033[33m "维护已启动，无需再起启动"\033[0m"
		sleep 1
	fi
}
function killwh()
{
	pkill -f 自动维护
	echo -e "\033[33m "维护已关闭"\033[0m"
		sleep 1
}
function whgames()
{
	while :
	do
	echo 游戏更新:$whgamez
	echo 是否开启游戏更新 [1] 开启 [2] 关闭
	echo
		read whgamess
			case $whgamess in
				1)whgam=true
				break;;
				2)whgam=false
				break;;
				*)
				echo 没有此选项请重新选择
			esac
	done
		sed -i "s/gameupdates=${whgame}/gameupdates=$whgam/g" k.sh
}
function whmods()
{
	while :
	do
	echo 模组更新:$whmodz
	echo 是否开启模组更新 [1] 开启 [2] 关闭
	echo
		read whmodss
			case $whmodss in
				1)whmo=true
				break;;
				2)whmo=false
				break;;
				*)
				echo 没有此选项请重新选择
			esac
	done
		sed -i "s/modupdates=${whmod}/modupdates=$whmo/g" k.sh
}
function whzqs()
{
	while :
	do
	echo 异常自启:$whzqz
	echo 是否开启异常自启 [1] 开启 [2] 关闭
	echo
		read whzqss
			case $whzqss in
				1)whz=true
				break;;
				2)whz=false
				break;;
				*)
				echo 没有此选项请重新选择
			esac
	done
		sed -i "s/game_selfstart=${whzq}/game_selfstart=$whz/g" k.sh
}
function whsz()
{
	cd $HOME
	whgame=$(cat k.sh |grep -o "gameupdates=.*"| awk -F"=" '{print $2}'|head -n 1)
	whmod=$(cat k.sh |grep -o "modupdates=.*"| awk -F"=" '{print $2}'|head -n 1)
	whzq=$(cat k.sh |grep -o "game_selfstart=.*"| awk -F"=" '{print $2}'|head -n 1)
		if [[ ${whgame} == true ]];then
		whgamez="开启"
		elif [[ ${whgame} == false ]];then
			whgamez="关闭"
		fi
		if [[ ${whmod} == true ]];then
			whmodz="开启"
		elif [[ ${whmod} == false ]];then
			whmodz="关闭"
		fi
		if [[ ${whzq} == true ]];then
			whzqz="开启"
		elif [[ ${whzq} == false ]];then
			whzqz="关闭"
		fi
	while :
		do
		echo [ 1]游戏更新：${whgamez}
		echo [ 2]模组更新：${whmodz}
		echo [ 3]异常自启：${whzqz}

		echo -e "\033[33m "[提示] 选择你要更改的选项,输入[0]退出 "\033[0m"
		echo
			read main1
				case $main1 in
					1)whgames
					whsz
					break;;
					2)whmods
					whsz
					break;;
					3)whzqs
					whsz
					break;;
					0)
					break;;
				esac
		done
}
function SetAdmin()
{
	cd $HOME
	if [ -f "$HOME/.klei/DoNotStarveTogether/MyDediServer/adminlist.txt" ];then
	cat "$HOME/.klei/DoNotStarveTogether/MyDediServer/adminlist.txt" | while read line
	do
		echo -e "\033[36m 管理员名单: $line\033[0m"
	done
	else
		echo ''
	fi
	echo -e "\033[33m [提示]:[1]提升管理员 [2]解除管理员 [0]返回 \033[0m"
	read -p "请输入编号：" admin1
	case $admin1 in
	1)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m 请输入要提升为管理员的Klei ID,[0]返回\033[0m"
	echo -e "\033[33m "============================================"\033[0m"
	read -p " 请输入Klei ID：" ID2
		if [[ "${ID2}" == "0" ]];then
			SetAdmin
		elif [[ "${ID2}" == "" ]];then
			echo -e "\033[33m " 不可为空 "\033[0m"
			SetAdmin
		else
			if [[ ! `grep "$ID2" .klei/DoNotStarveTogether/MyDediServer/adminlist.txt` ]]
			then
				echo $ID2 >> "$HOME/.klei/DoNotStarveTogether/MyDediServer/adminlist.txt"
#				echo "" >> adminlist.txt
				echo " $ID2管理员已设置"
				sleep 2
			else
				echo " 已是管理员无需再次添加"
				sleep 2
			fi
		fi
	;;
	2)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m      请输入要解除的管理员的Klei ID,[0]返回\033[0m"
	echo -e "\033[33m "============================================"\033[0m"
	read -p " 请输入Klei ID：" ID2
		if [[ "${ID2}" == "0" ]];then
			SetAdmin
		elif [[ "${ID2}" == "" ]];then
			echo -e "\033[33m " 不可为空 "\033[0m"
			SetAdmin
		else
		if cat ".klei/DoNotStarveTogether/MyDediServer/adminlist.txt" | grep "$ID2"
		then
			sed -i "/$ID2/d" "$HOME/.klei/DoNotStarveTogether/MyDediServer/adminlist.txt"
			echo " $ID2管理员已取消"
			sleep 2
		else
			echo " $ID2该玩家不是管理员"
			sleep 2
		fi
	fi
	;;
	0)
	Listmanage
	break;;
	esac
	SetAdmin
}
function SetBlack()
{
	cd $HOME
	if [ -f "$HOME/.klei/DoNotStarveTogether/MyDediServer/blacklist.txt" ];then
	cat "$HOME/.klei/DoNotStarveTogether/MyDediServer/blacklist.txt" | while read line1
	do
		echo -e "\033[36m 管理员名单: $line1\033[0m"
	done
	else
		echo ''
	fi
	echo -e "\033[33m [提示]: "[1]加入黑名单 [2]放出黑名单 [0]返回 " \033[0m"
	read -p "请输入编号：" black1
	case $black1 in
	1)
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m      请输入要加入黑名单的Klei ID,[0]返回\033[0m"
	echo -e "\033[33m "============================================"\033[0m"
	read -p " 请输入Klei ID：" ID2
		if [[ "${ID2}" == "0" ]];then
			SetBlack
		elif [[ "${ID2}" == "" ]];then
			echo -e "\033[33m " 不可为空 "\033[0m"
			SetBlack
		else
			if [[ ! `grep "$ID2" .klei/DoNotStarveTogether/MyDediServer/blacklist.txt` ]]
			then
				echo $ID2 >> "$HOME/.klei/DoNotStarveTogether/MyDediServer/blacklist.txt"
				echo "恶劣的家伙已被关入地上小黑屋"
				sleep 2
			else
				echo "恶劣的家伙已经在小黑屋"
				sleep 2
			fi
		fi
	;;
	2)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m      请输入要解除黑名单的Klei ID,[0]返回\033[0m"
	echo -e "\033[33m "============================================"\033[0m"
	read -p " 请输入Klei ID：" ID2
		if [[ "${ID2}" == "0" ]];then
			SetBlack
		elif [[ "${ID2}" == "" ]];then
			echo -e "\033[33m " 不可为空 "\033[0m"
			SetBlack
		else
				if [[ `grep "$ID2" .klei/DoNotStarveTogether/MyDediServer/blacklist.txt` ]]
				then
					sed -i "/$ID2/d" "$HOME/.klei/DoNotStarveTogether/MyDediServer/blacklist.txt"
					cd $HOME
					echo "已放出地上小黑屋"
					sleep 2
				else
					echo "这个基佬不在小黑屋"
					sleep 2
				fi
		fi
	;;
	0)
	Listmanage
	break;;
	esac
	SetBlack
}
function SetWhite()
{
	cd $HOME
	if [ -f "$HOME/.klei/DoNotStarveTogether/MyDediServer/whitelist.txt" ];then
	cat "$HOME/.klei/DoNotStarveTogether/MyDediServer/whitelist.txt" | while read line
	do
		echo -e "\033[36m 管理员名单: $line\033[0m"
	done
	else
		echo ''
	fi
	echo -e "\033[33m [提示]:"[1]加入白名单 [2]放出白名单 [0]返回" \033[0m"
	read -p "请输入编号：" white1
	case $white1 in
	1)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m      请输入要加入白名单的Klei ID,[0]返回\033[0m"
	echo -e "\033[33m "============================================"\033[0m"
	read -p " 请输入Klei ID：" ID2
		if [[ "${ID2}" == "0" ]];then
			SetWhite
		elif [[ "${ID2}" == "" ]];then
			echo -e "\033[33m " 不可为空 "\033[0m"
			SetWhite
		else
			if [[ ! `grep "$ID2" $HOME/.klei/DoNotStarveTogether/MyDediServer/whitelist.txt` ]]
			then
				echo $ID2 >> $HOME/.klei/DoNotStarveTogether/MyDediServer/whitelist.txt
				echo "已为这个大佬预留一个位置"
			else
				echo "这个大佬已经有一个位置"
			fi
		fi
	;;
	2)
	cd $HOME
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m      请输入要解除白名单的Klei ID,[0]返回\033[0m"
	echo -e "\033[33m "============================================"\033[0m"
	read -p " 请输入Klei ID：" ID2
		if [[ "${ID2}" == "0" ]];then
			SetWhite
		elif [[ "${ID2}" == "" ]];then
			echo -e "\033[33m " 不可为空 "\033[0m"
			SetWhite
		else
			if [[ `grep "$ID2" $HOME/.klei/DoNotStarveTogether/MyDediServer/whitelist.txt` ]]
			then
				sed -i "/$ID2/d" "$HOME/.klei/DoNotStarveTogether/MyDediServer/whitelist.txt"
				echo "预留位置已开放"
			else
				echo "没有这个基佬的预留位置"
			fi
	fi
	;;
	0)
	Listmanage
	break;;
	esac
	SetWhite
}
function Listmanage()
{
while :
do
	echo -e "\033[33m "============================================"\033[0m"
	echo -e "\033[33m "[提示]:[1]管理员 [2]黑名单 [3]白名单 [0]返回菜单"\033[0m"
	read -p "请输入编号：" list1
	case $list1 in
		1)SetAdmin
		break;;
		2)SetBlack
		break;;
		3)SetWhite
		break;;
		0)Main
		break;;
	esac
done
}
function jiance()
{
	cd $HOME
		echo -e "\033[36m[提示]: 自动检测是否下载完整 \033[0m"
	if [[ ! -d "./Steam" ]];then
		echo -e "\033[36m[提示]: 没有检测到Steam文件 \033[0m"
		echo -e "\033[36m[提示]: 开始自动修复请耐心等待 \033[0m"
		Gameupdate
	elif [[ ! -d "./.steam" ]];then
		echo -e "\033[36m[提示]: 没有检测到.steam文件 \033[0m"
		echo -e "\033[36m[提示]: 开始自动修复请耐心等待 \033[0m"
		Gameupdate
	elif [[ ! -f "dst/mods/dedicated_server_mods_setup.lua" ]];then
		echo -e "\033[36m[提示]: 开始自动修复请耐心等待 \033[0m"
		echo -e "\033[36m[提示]: 没有检测到模组存储文件 \033[0m"
		Gameupdate
	elif [[ ! -f "dst/version.txt" ]];then
		echo -e "\033[36m[提示]: 没有检测到游戏版本号 \033[0m"
		echo -e "\033[36m[提示]: 开始自动修复请耐心等待 \033[0m"
		Gameupdate
	else
		echo -e "\033[36m[提示]: 自检完毕 \033[0m"
	fi
}

function jiance1()
{
	jiance
	clear
	echo -e "\033[35m[提示]:steamcmd路径:$HOME/steamcmd \033[0m"
	echo -e "\033[35m[提示]:如果游戏无法正常启动或某些功能无法使用请使用依赖功能 \033[0m"
	echo -e "\033[35m[提示]:脚本存放位置：$HOME/$0\033[0m"
	echo -e "\033[35m[提示]:存档路径:$HOME/.klei/DoNotStarveTogether/MyDediServer\033[0m"
	echo -e "\033[35m[提示]:开服请尽量从本地开好档后上传到云服，游戏更新后某些选        项不正常了\033[0m"
		cd "$MyDediServers"
		allsave=$(ls -l  | grep ^d | awk '{print $9}')
		for save in ${allsave}; do
		  test=$(cat $HOME/.klei/DoNotStarveTogether/MyDediServer/$save/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
		  array=($test)
		  dko=$(cat $save/server.ini |grep -o "id = .*"| awk -F"= " '{print $2}'|head -n 1)
			echo -e "\033[35m[提示]:世界端口:"$dko" 存档世界文件名:$save 模组数量:${#array[@]}\033[0m"
		done
}
function modup()
{
	echo -e "\033[36m开始更新模组 \033[0m"
	cd $MyDediServers
		allsave=$(ls -l  | grep ^d | awk '{print $9}')
		for save in ${allsave}; do
		cd $HOME
		test=$(cat .klei/DoNotStarveTogether/MyDediServer/$save/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
		array=($test)
		echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
		for((i=0;i<${#array[@]};i++))
			do
		#	echo ${array[$i]}
			if cat "$game" | grep "ServerModSetup("\"${array[$i]}\"")"
			then
			echo "此模组已下载"
			else
			echo "没有这个模组正在写入"
			echo "ServerModSetup("\"${array[$i]}\"")" >> "$game"
			fi
		done
	done
	cd "$gamesPath"
	screen -S "更新" "$gamesFile" -only_update_server_mods -ugc_directory ${ugc_directory} -persistent_storage_root ${dst_conf_basedir} -conf_dir ${dst_conf_dirname} -cluster Download -shard Master1
  echo -e "\033[33m 正在检测是否有未下载/更新成功的模组\033[0m"
  if cat "${HOME}/.klei/DoNotStarveTogether/Download/Master1/server_log.txt" | grep "OnDownloadPublishedFile" >/dev/null 2>&1; then
    echo -e "\033[33m检测到有模组为下载/更新成功再次更新\033[0m"
    modup
  elif cat "${HOME}/.klei/DoNotStarveTogether/Download/Master1/server_log.txt" | grep "DownloadPublishedFile" >/dev/null 2>&1; then
    echo -e "\033[33m检测到有模组为下载/更新成功再次更新\033[0m"
    modup
  fi
}
function mod_shezhi()
{
while :
do
  clear
	echo -e "\033[33m[提示]:模组功能最好还是不要用了bug满天飞， \033[0m"
	echo -e "\033[33m[提示]:如果你的所有模组是直接用脚本添加的可以使用，如果是从        本地开好服传到云服的用这个功能会启动不了世界 \033[0m"
	echo -e "\033[36m[提示]:[1]更新mod [2]添加mod [3]删除mod [4]修改MOD配置 [5]安装MOD合集 [0]返回 \033[0m"
	read -p "请输入编号：" mod_shezhia
	case $mod_shezhia in
		1)
      modup
      clear
      mod_shezhi
      break;;
    2)
      Listallmod
      Addmod
      Removelastcomma
      ;;
    3)
      flag=true
      Listusedmod
      if [[ $flag == "true" ]]
      then
        Delmod
      fi
      Removelastcomma
      ;;
    4)
      Mod_Cfg
      Removelastcomma
      ;;
    5)
      clear_mod_cfg
      Removelastcomma
      ;;
    6)
      Install_mod_collection
      Removelastcomma
      ;;
		0)Main
		break;;
	esac
done
}
function dimain()
{
cd $HOME
screen -dmS "Dst Master$input_save" "$gamesFile" -skip_update_server_mods -ugc_directory ${ugc_directory} -persistent_storage_root ${dst_conf_basedir} -conf_dir ${dst_conf_dirname} -cluster MyDediServer -shard Master${input_save}
}
function dongxue()
{
cd $HOME
screen -dmS "Dst Caves$input_save" "$gamesFile" -skip_update_server_mods -ugc_directory ${ugc_directory} -persistent_storage_root ${dst_conf_basedir} -conf_dir ${dst_conf_dirname} -cluster MyDediServer -shard Caves${input_save}
}
function yiqi()
{
cd $HOME
test=$(cat .klei/DoNotStarveTogether/MyDediServer/$save/modoverrides.lua |grep '"workshop-' | cut -d '-' -f 2 | cut -d '"' -f1)
array=($test)
echo -e "\033[33m检测到${#array[@]}个模组\033[0m"
for((i=0;i<${#array[@]};i++))
	do
#	echo ${array[$i]}
if cat "$game" | grep "ServerModSetup("\"${array[$i]}\"")"
then
echo "此模组已下载"
else
echo "没有这个模组正在写入"
echo "ServerModSetup("\"${array[$i]}\"")" >> ./"$game"
fi
done
sleep 1
cd $HOME
cd "$gamesPath"
screen -dmS "Dst Master$input_save" "$gamesFile" -console -cluster MyDediServer -shard Master$input_save
screen -dmS "Dst Caves$input_save" "$gamesFile" -console -cluster MyDediServer -shard Caves$input_save
}
function dand()
{
	cd $HOME
	echo -e "\033[34m [提示]:启动 [1.地面] [2.洞穴] [3.地面+洞穴]\033[0m"
	read -p "请输入编号：" input_mode
	echo -e "\033[34m[提示] 存档位 [1-5]\033[0m"
	read -p "请输入编号：" input_save
	case $input_mode in
		1)
			dimain;;
		2)
			dongxue;;
		3)
			yiqi;;
		*)
			echo -e "\033[31m[注意] Illegal Command,Please Check\033[0m" ;;
	esac
	Main
}
function ipopen()
{
	txtip=$(curl ip.sb)
	cd "$MyDediServers"
	roompass=$(cat cluster.ini |grep -i "cluster_password = .*"| awk -F"= " '{print $2}'|head -n 1)
	allsave=$(ls -l  | grep ^d | awk '{print $9}')
	for save in ${allsave}; do
		wordlist=${save}
		cd "$MyDediServers"
		ipmain=$(cat $wordlist/server.ini |grep -i "is_master = .*"| awk -F"= " '{print $2}'|head -n 1)
		if [[ $ipmain == true ]];then
		  wordidss=$(cat $wordlist/server.ini |grep -i "server_port = .*"| awk -F"= " '{print $2}'|head -n 1)
		clear
		if [[ $roompass != '' ]];then
		  echo -e "\033[36m -------------------------------------------------------------\033[0m"
		  echo -e "\033[36m -------------------------------------------------------------\033[0m"
		  echo -e "\033[36m -------------------------------------------------------------\033[0m"
		  echo -e "\033[36m -------------------------------------------------------------\033[0m"
          rr="c_connect(\"$txtip\",$wordidss,$roompass)"
        else
		  echo -e "\033[36m ------------------------------------------------------------\033[0m"
		  echo -e "\033[36m ------------------------------------------------------------\033[0m"
		  echo -e "\033[36m ------------------------------------------------------------\033[0m"
		  echo -e "\033[36m ------------------------------------------------------------\033[0m"
         rr=" c_connect(\"$txtip\",$wordidss)"
        fi
	  fi
	done
	echo "${rr}"
	while :; do
        echo -e "\033[33m [提示]:按 ~ 键调出控制台,粘贴上方c_connect(“xx.xx.xx.xx”) \033[0m"
        echo -e "\033[33m        就可以直连我们的服务器了！输入[0]退出\033[0m"
	  	read -p " [提示]:请输入编号：" zeze
		case $zeze in
			0)break;;
   		esac
	done
}
function Gameupdate1()
{
  new_game_version=$(curl -s 'https://forums.kleientertainment.com/game-updates/dst/' | grep 'data-currentRelease' | cut -d '/' -f6 | cut -d '-' -f1 | sort -r | head -n 1 | tr -cd '[0-9]' )
  cur_game_version=$(cat "${HOME}/dst/version.txt")
	outputTips 33 "最新版本$new_game_version"
  outputTips 33 "本地版本$cur_game_version"
	outputTips 33 更新游戏会自动关闭所有存档
	echo 是否更新:    1.更新2.退出
	read -p "请输入编号：" updates
  if [[ $updates == 1 ]];then
    killallscreen
    Gameupdate
  elif [[ $updates == 2 ]];then
    Main
  fi
}
function Gameupdate()
{
  cd $HOME
  cd ./steamcmd
#	./steamcmd.sh +login anonymous +app_update 343050 validate +quit
./steamcmd.sh +login anonymous +force_install_dir ~/dst +app_update 343050 validate +quit
	cd "$HOME"
	clear
	echo "更新完毕"
	Main
}
function Library()
{
  # 检查当前系统信息
  if [[ -f "/etc/redhat-release" ]]; then
    release="centos"
  elif cat /etc/issue | grep -q -E -i "debian"; then
    release="debian"
  elif cat /etc/issue | grep -q -E -i "ubuntu"; then
    release="ubuntu"
  elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
    release="centos"
  elif cat /proc/version | grep -q -E -i "debian"; then
    release="debian"
  elif cat /proc/version | grep -q -E -i "ubuntu"; then
    release="ubuntu"
  elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
    release="centos"
  fi
  if [[ "${release}" != "ubuntu" && "${release}" != "debian" && "${release}" != "centos" ]]; then
    error "很遗憾！本脚本暂时只支持Debian7+和Ubuntu18.0+和CentOS7+的系统！" && exit 1
  fi
  bit=$(uname -m)
  mybit=$(getconf LONG_BIT)
  scriptfile=${release}_${mybit}.sh
  echo -e "\033[33m正在安装依赖库\033[0m"
  if [[ "${release}" != "centos" ]]; then
    sudo apt update && apt upgrade -y
        if grep -sq '^VERSION_ID="18.04"' /etc/os-release; then
                requires=(lib32gcc1 lua5.3 screen wget git curl)
        else
                requires=(lib32gcc-s1 lua5.3 screen wget git curl)
        fi
        for inst in ${requires[@]}; do
          sudo apt install -y $inst
        done
  else
    #	下面是centos用户的
    sudo yum -y install zip
    sudo yum -y install glibc.i686 libstdc++.i686 screen libcurl.i686 wget
    cd /usr/lib
    ln -s libcurl.so.4 libcurl-gnutls.so.4
    cd /usr/lib64
    ln -s libcurl.so.4 libcurl-gnutls.so.4
    lua -v
    if [ $? -ne 0 ]; then
      wget https://tools.wqlin.com/dst/lua-5.1.5.tar.gz -O ${DST_HOME}/lua-5.1.5.tar.gz -T 10
      tar -zxvf ${DST_HOME}/lua-5.1.5.tar.gz -C ${DST_HOME}/lua
      cd ${DST_HOME}/lua
      sudo make linux test
      sudo make install
      cd $HOME
    fi
  fi
}
function nemw()
{
	cd $HOME
	if [[ ! -d "./.klei/DoNotStarveTogether/MyDediServer" ]];then
		mkdir -p ./.klei/DoNotStarveTogether/MyDediServer
	fi
}
function Prepare()
{
	cd $HOME
	if [[ ! -d "$data_dir" ]];then
		mkdir -p "$data_dir"
	fi
	if [[ ! -d "$mod_cfg_dir" ]];then
		mkdir -p "$mod_cfg_dir"
		Initfiles
	fi
	if [[ ! -d "~/dst" ]];then
		mkdir -p "dst"
		Initfiles
	fi
if [[ ! -e ~/steamcmd ]]; then mkdir ~/steamcmd; fi

if [[ -e ~/steamcmd/steamcmd.sh ]]; then
      outputTips 'steamcmd.sh已存在～'
  else
    Library
    echo -e "\033[33m正在下载安装SteamCmd\033[0m"
    wget --output-document ~/steamcmd/steamcmd_linux.tar.gz 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' && tar -xvzf ~/steamcmd/steamcmd_linux.tar.gz --directory ~/steamcmd
      if [[ $? ]]; then
          outputTips 'steamcmd.sh脚本下载完成！'
          rm -f ~/steamcmd/steamcmd_linux.tar.gz > /dev/null 2>&1
      else
        outputTips '出bug了哈哈哈！！！请联系管理员(黎明或者小休???)'
        exit 1
      fi
    echo -e "\033[33mSteamCmd安装完成\033[0m"
    echo -e "\033[正在下载饥荒,时间较长请耐心等待\033[0m"
    ~/steamcmd/steamcmd.sh +force_install_dir "$dst_home" +login anonymous +app_update 343050 +quit
    echo -e "\033[正在下载饥荒,时间较长请耐心等待\033[0m"
    jiance
fi
}
function Main()
{
  while :; do
    jiance1
    outputOptionsReset
    time2=$(date "+%Y%m%d%H%M%S")
    time3=$(date "+%Y-%m-%d %H:%M:%S")
    outputInterval 33
    outputTips 33 欢迎使用哉亚一键端饥荒专用服务器架设器
    outputInterval 33
    outputOptions2 36 启动 重启 查看 关闭 依赖
    outputOptions2 36 更新 回档 重置 备份 恢复
    outputOptions2 36 占位 救赎 设置 维护 名单
    outputOptions2 36 模组 单独 直连 说明 占位
	  read -p "请输入编号：" main1
		case $main1 in
			1)qirun
			break;;
			2)cq
			break;;
			3)openServer
			break;;
			4)killprocess
			break;;
			5)yilai
			Main
			break;;
			6)Gameupdate1
			break;;
			7)retreated
			break;;
			8)chongzhi
			break;;
			9)beifeng
			break;;
			10)huifu
			break;;
			11)shen
			break;;
			12)jiushu
			break;;
			13)shezhi
			break;;
			14)ziwh
			break;;
			15)Listmanage
			break;;
			16)mod_shezhi
			break;;
			17)dand
			break;;
			18)ipopen
			Main
			break;;
			19)Create_warning
			break;;
	    20)whh
	    break;;
			*)
			echo 没有此选项请重新选择
		esac
done
}
outputInterval 33
outputTips 33                    欢迎使用
outputInterval 33
Prepare
echo -e "\033[33m 准备完毕\033[0m"
outputInterval 33
Initfiles
queshi
nemw
Main
