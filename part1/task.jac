node Task{
    has title:str;
    has status:str="pending";
    has priority:int =1;

}

edge DependsOn{

}
walker CheckReady{
    has ready_tasks:list =[];

    can start with `root entry{
        visit [-->];

    }

    can check with Task entry{
        if here.status !="pending"{
            return;
        }
        dependencies =[here ->:DependsOn:->];
        all_done=True;

        for dep in dependencies{
            if dep.status =="pending"{
                all_done = False;
                break;
            }
        }
        if all_done{
            self.ready_tasks.append(here.title);
        }

    }
}


walker MarkComplete{
    has task_title:str;

    can start with `root entry{
        visit [-->];
    }

    can mark with Task entry{
        if here.title ==self.task_title{
            here.status ="complete";
            print(f"Completed task:{here.title}");

            disengage;
        }
        visit[-->];
    }

}

with entry{
    task1= Task(title="Design Databases Schema" , priority = 3);
    task2= Task(title="Implement    API", priority = 3);
    task3 = Task(title="Create Frontend", priority = 2);
    task4= Task(title="Write Unit Tests", priority = 2);
    task5 = Task(title="Deploy to Production", priority = 3);

# Define dependencies 
    task2 +>:DependsOn:+> task1;
    task3 +>:DependsOn:+>task2;
    task4 +>:DependsOn:+> task2;
    task5 +>:DependsOn:+> task3;
    task5 +>:DependsOn:+> task4;

# Connect to root 
    root ++>task1;
    root ++>task2;
    root ++>task3;
    root ++>task4;
    root ++>task5;

    checker=CheckReady();
    root spawn checker;;
    print(f"Ready tasks to start: {checker.ready_tasks}");


    root spawn MarkComplete(task_title="Design Databases Schema");

    checker2=CheckReady();
    root spawn checker2;
    print(f"Ready tasks to start after completing one task: {checker2.ready_tasks}");

}
