# joebo http://picolisp.com/wiki/?taskdb
#
# usage
# (task-add "call home")       ## add a task with default priority
# (task-add "get breakfast" 1) ## add a task with high priority
# (task-all)                   ## show tasks
# (task-done 1)                ## show tasks
# (task-all-open)              ## show open/closed tasks
# (task-due 1 "2016-08-24")    ## sets task due date
# (task-all-due "2016-01-01" "2017-01-01") ## searches for tasks due in range

(setq *DateSep "-")            ## separate dates with - (e.g. 2016-08-24)

(class +Task +Entity)         # starts the entity definition
(rel nr (+Need +Key +Number)) # defines a key, needed collect/query
(rel nm (+String))            # task name
                              # NOTE: +Ref must be specified before +Number
(rel pri (+Ref +Number))      # task priority, with index to support (collect 'pri '+Task 1)
(rel due (+Ref +Date))        # task due date
(rel status (+Ref +String))   # task status

(pool "tasks.db")             # initial database (consider block size)

# adds a task. Uses default priority of 1000 if not specified
# usage (task-add "call home")
(de task-add (Task Priority Due)
   (new! 
      '(+Task)
      'nr (genKey 'nr '+Task)
      'nm Task
      'pri (or Priority 1000)
      'due Due
      'status "NEW") )

# fetches properties of a task from an external symbol
# usage (task-show '{4})
(de task-show (This)
   (list 
      'nr (: nr)
      'nm (: nm)
      'pri (: pri)
      'due (: due)
      'status (: status) ) )

# returns a list of all tasks
# usage (task-all)
(de task-all ()
   (mapcar task-show (collect 'nr '+Task)) )

# sets a task to be done
# usage (task-done 1)
(de task-done (Nr)
   (put!> (db 'nr '+Task Nr) 'status "DONE") )

# finds open tasks
(de task-all-open ()
   (mapcar task-show (collect 'status '+Task "OPEN")) )

# finds done tasks
(de task-all-done ()
   (mapcar task-show (collect 'status '+Task "DONE")) )

# sets a task due date
# usage (task-due 1 "2016-08-24")
(de task-due (Nr Due)
   (put!> (db 'nr '+Task Nr) 'due ($dat Due *DateSep)) ) 

# finds task by due date
# usage (task-all-due "2016-08-16") or (task-all-due "2016-01-01" "2017-01-01")
(de task-all-due (Start End)
   (mapcar 
      task-show
      (collect 
         'due 
         '+Task ($dat Start *DateSep) ($dat (or End Start) *DateSep) ) ) )

