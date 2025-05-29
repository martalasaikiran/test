trigger triggertask2 on Account (after update) {
    if (Trigger.IsAfter && Trigger.IsUpdate) {
        AccountTask2.separationRecordsManagerNotNullValues(Trigger.New);
    }
}