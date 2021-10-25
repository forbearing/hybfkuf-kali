#!/usr/bin/env sh

export boot_src="/.boot/"
export boot_dst="._boot/"
export etc_src="/.etc/"
export etc_dst="/._etc/"
export root_src="/.root/"
export root_dst="/._root/"
export run_src="/.run/"
export run_dst="/._run/"
export usr_src="/.usr/"
export usr_dst="/._usr/"
export var_src="/.var/"
export var_dst="/._var/"

# private function
# record begin time
_begin_time() {
    printf "\n%s begin at $(date +"%Y-%m-%d %H:%M:%S\n")" "$1"
}
# private function
# record end time
_end_time() {
    printf "%s end at $(date +"%Y-%m-%d %H:%M:%S")\n\n" "$1"
}

boot_sync() {
    if [ -f ${boot_dst}/.flag ]; then
        echo "[boot] sync already finished, skiping..."
        return $? ; fi

    _begin_time "[boot] sync"
    rsync -aH -q --delete ${boot_src} ${boot_dst}
    boot_sync_rc=$?
    if [ ${boot_sync_rc} -eq 0 ]; then
        echo "[boot] sync Successful."
        touch ${boot_dst}/.flag
    else
        echo "[boot] sync Failed with Status: ${boot_sync_rc}."
    fi
    _end_time "[boot] sync"
}

etc_sync() {
    if [ -f ${etc_dst}/.flag ]; then
        echo "[etc] sync already finished, skiping..."
        return $?; fi

    _begin_time "[etc] sync"
    rsync -aH -q --delete \
        --exclude='hosts' \
        --exclude='resolv.conf' \
        --exclude='hostname' \
        ${etc_src} ${etc_dst}
    etc_sync_rc=$?
    if [ ${etc_sync_rc} -eq 0 ]; then
        echo "[etc] sync Successful."
        touch ${etc_dst}/.flag
    else
        echo "[etc] sync Failed with Status: ${etc_sync_rc}."
    fi
    _end_time "[etc] sync"
}

root_sync() {
    if [ -f ${root_dst}/.flag ]; then
        echo "[root] sync already finished, skiping..."
        return $?; fi
    _begin_time "[root] sync"
    rsync -aH -q --delete ${root_src} ${root_dst}
    root_sync_rc=$?
    if [ ${root_sync_rc} -eq 0 ]; then
        echo "[root] sync Successful."
        touch ${root_dst}/.flag
    else
        echo "[root] sync Failed with Status: ${root_sync_rc}."
    fi
    _end_time "[root] sync"
}

run_sync() {
    if [ -f ${run_dst}/.flag ]; then
        echo "[run] sync already finished, skiping..."
        return $?; fi

    _begin_time "[run] sync"
    rsync -aH -q --delete ${run_src} ${run_dst}
    run_sync_rc=$?
    if [ ${run_sync_rc} -eq 0 ]; then
        echo "[run] sync Successful."
        touch ${run_dst}/.flag
    else
        echo "[run] sync Failed with Status: ${run_sync_rc}."
    fi
    _end_time "[run] sync"
}

usr_sync() {
    if [ -f ${usr_dst}/.flag ]; then
        echo "[usr] sync already finished, skiping..."
        return $?; fi

    _begin_time "[usr] sync"
    rsync -aH -q --delete ${usr_src} ${usr_dst}
    usr_sync_rc=$?
    if [ ${usr_sync_rc} -eq 0 ]; then
        echo "[usr] sync Successful."
        touch ${usr_dst}/.flag
    else
        echo "[usr] sync Failed with Status: ${usr_sync_rc}"
    fi
    _end_time "[usr] sync"
}

var_sync() {
    if [ -f ${var_dst}/.flag ]; then
        echo "[var] sync already finished, skiping..."
        return $?; fi

    _begin_time "[var] sync"
    rsync -aH -q --delete ${var_src} ${var_dst}
    var_sync_sc=$?
    if [ ${var_sync_sc} -eq 0 ]; then
        echo "[var] sync Successful."
        touch ${var_dst}/.flag
    else
        echo "[var] sync Failed with Status: ${var_sync_sc}"
    fi
    _end_time "[var] sync"
}

boot_sync
etc_sync
root_sync
run_sync
usr_sync
var_sync
