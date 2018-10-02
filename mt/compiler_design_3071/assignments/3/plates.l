// Regex for 161 etc
(1{1}[3-8]{1}[1-2]{1})      // Catch YY part
([\-][C-W]{1,2}[\-])        // Catch CC part
([\-]{1}[0-9]{1,6})         // Catch SSSSSS part

// Regex for pre 161
(8{1}[7-9]{1})|(9{1}[0-9]{1})|(1{1}[0-2]{1})  // Catch YY part
([\-][C-W]{1,2}[\-])                          // Catch CC part
([\-]{1}[0-9]{1,6})                           // Catch SSSSSS part
