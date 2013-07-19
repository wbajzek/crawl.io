doFile("io-json/json.io")

URL fetchSlot ::= method(slot, self fetch parseJson getSlot(slot))

fetch := method(
  url := URL with(System args at(1))
  doc := url fetch parseJson
  doc records foreach(record,
    record links slotNames foreach (slot,
      // add a method to the record object which is populated with the
      // content fetched from the link.
      record addSlot(slot,
        // use @ so fetch happens asynchronously and only blocks if 
        // it's not been received by the time it's accessed
        URL with(record links getSlot(slot)) @fetchSlot(slot))))

  doc asJson println
)

// time it
Date cpuSecondsToRun(fetch) println
