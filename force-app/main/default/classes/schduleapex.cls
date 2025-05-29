Global class schduleapex  implements Schedulable{
     global void execute(SchedulableContext SC) {
      batchapex1 bt1 = new batchapex1();
      Database.executeBatch(bt1,5);
   }

}