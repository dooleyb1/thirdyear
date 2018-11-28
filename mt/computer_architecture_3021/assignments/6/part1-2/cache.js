class Cache {

  // L -> Bytes per cache line
  // K -> Data directories
  // N -> Sets of cache lines/tags

  constructor(L, K, N){
    // L, K, N Variables for K-Way Cache
    this.L = L;
    this.K = K;
    this.N = N;

    // Set cache tag variables
    this.set_selector_bits_length = Math.log2(N);
    this.size = L * K * N;

    // Cache matrix
    this.cache_matrix = [];
    this.initialiseCache(this.cache_matrix)

    // Display initialised cache
    this.printStats()
  }

  initialiseCache(cache){

    // All sets will be invalid at start
    var initial_invalid = 0;
    var empty_data = "";

    // For each cache set - down (N)
    for(var i=0; i<this.N; i++){

      // Generate binary for set number and set valid to 0
      var set_number = (i).toString(2).padStart(this.set_selector_bits_length, 0);

      this.cache_matrix.push([set_number, initial_invalid])

      // For each cache directory in set - across (K)
      for(var j=0; j<this.K; j++) {

        var last_updated = this.getTime()

        this.cache_matrix[i].push([initial_invalid, empty_data, last_updated])

      }
    }
  }

  getTime(){
    var d = new Date()
    return d.getTime();
  }

  printStats(){
    console.log("\n\n-----------------------------------------");
    console.log("            CACHE PARAMETERS             ");
    console.log("-----------------------------------------");
    console.log("L (Bytes per cache line)   -> " + this.L);
    console.log("K (Cache lines per set)    -> " + this.K);
    console.log("N (Number of sets)         -> " + this.N);
    console.log("\n\n-----------------------------------------");
    console.log("            CACHE INFORMATION             ");
    console.log("-----------------------------------------");
    console.log("Cache Size                 -> " + this.size);
    console.log("Set Selector Length (Bits) -> " + this.set_selector_bits_length);
  }

  printCache(){
    // For each cache set - down (N)
    for(var i=0; i<this.N; i++){

      // Generate binary for set number and set valid to 0
      var set_number = (i).toString(2).padStart(this.set_selector_bits_length, 0);

      this.cache_matrix.push([set_number, initial_invalid])

      // For each cache directory in set - across (K)
      for(var j=0; j<this.K; j++) {

        var last_updated = this.getTime()

        this.cache_matrix[i].push([initial_invalid, empty_data, last_updated])

      }
    }
  }

  hexToBinary(hex){
    return (parseInt(hex)).toString(2).padStart(16, 0);
  }

  disectBinary(binary){
    //    <-  0-12  ->      <- 12-14 ->
    // [BINARY_MINUS_OFFSET] [OFFSET]
    var binary_minus_offset = binary.substr(0,12);
    var offset = binary.substr(12, binary.length-1);

    //    <-  0-12  ->
    // [BINARY_MINUS_OFFSET]
    // [   TAG    ][BIT_SEL]
    var bit_selector_bits = binary_minus_offset.slice(-this.set_selector_bits_length);
    var tag_bits;

    if(binary_minus_offset.length-this.set_selector_bits_length != 0){
        tag_bits = binary_minus_offset.substr(0, binary_minus_offset.length-this.set_selector_bits_length);
    }

    if(this.N == 1){
      tag_bits = bit_selector_bits;
      bit_selector_bits = '0';
    }

    return [bit_selector_bits, tag_bits, offset];
  }

  find_lru(timestamps){
    var oldest = new Date(Math.min.apply(null, timestamps));
    var index = timestamps.indexOf(oldest)
    return index
  }

  handleOneDataDirectory(tag_bits, row){
    // If hasData == 0 then miss
    if(row[2][0] == 0){
      // Return miss and pretend fetch from memory
      row[2][1] = tag_bits;
      row[2][0] = 1;
      return("MISS");
    }
    // If hasData == 1
    else if(row[2][0] == 1){
      // && If tag_bits_match()
      if(row[2][1] == tag_bits)
        return("HIT");
      else{
        // Return miss and pretend fetch from memory
        row[2][1] = tag_bits;
        return("MISS")
      }
    }
  }

  handleLRUReplacement(tag_bits, row){
    var timestamps = [];

    // Loop over all possible data directories for the 1 set
    for(var index=0; index<=this.K; index++){
      timestamps.push(row[2+index][2]);

      // If directory has data and matches tag_bits --> HIT
      if(row[2+index][0] == 1 && row[2+index][1] == tag_bits){
        // Update time for LRU
        row[2+index][2] = this.getTime();
        return("HIT")
      }
    }

    // If no HIT found, check LRU and replace
    row[1] = this.find_lru(timestamps);
    var lru = row[1]

    // If empty, simulate MISS and fetch
    if(row[2+lru][0] == 0){
      row[2+lru][0] = 1;
      row[2+lru][1] = tag_bits;
      row[2+lru][2] = this.getTime();
      return("MISS");
    }
    // Otherwise, replace entry and simulate MISS and fetch
    else if(row[2+lru][0] == 1){
      row[2+lru][1] = tag_bits;
      row[2+lru][2] = this.getTime();
      return("MISS");
    }
  }

  hitOrMiss(bit_selector_bits, tag_bits){
    // Iterate over every row in matrix
    for(var i=0; i<this.cache_matrix.length; i++){
      var row = this.cache_matrix[i]
      // If bit_selector_bits matches cache matrix
      if(bit_selector_bits == row[0]){
        // If only one data directory
        if(this.K == 1){
          return this.handleOneDataDirectory(tag_bits, row);
        }
        // Otherwise, handle LRU replacement
        else{
          return this.handleLRUReplacement(tag_bits, row);
        }
      }
    }
  }
}

const cache = new Cache(16, 1, 8);

var input = ["0x0000","0x0004","0x000c","0x2200","0x00d0","0x00e0","0x1130","0x0028",
        		 "0x113c","0x2204","0x0010","0x0020","0x0004","0x0040","0x2208","0x0008",
        		 "0x00a0","0x0004","0x1104","0x0028","0x000c","0x0084","0x000c","0x3390",
        		 "0x00b0","0x1100","0x0028","0x0064","0x0070","0x00d0","0x0008","0x3394"]

var hits = 0;
var misses = 0;

// console.log("\n|   HEX  |  TAG BITS | DATA | OFFSET | RESULT ");
// console.log("-----------------------------------------------");

// Test all input hex addresses
for(var i=0; i<input.length; i++){

  console.log("\n\n-----------------------------------------");
  console.log("              CACHE BEFORE               ");
  console.log("-----------------------------------------");
  console.log(cache.cache_matrix)

  var hex = input[i];
  // Generate binary for hex address
  binary = cache.hexToBinary(hex);

  // Disect binary address
  disected_bits = cache.disectBinary(binary);
  bit_selector_bits = disected_bits[0];
  tag_bits = disected_bits[1];

  console.log("\n\n-----------------------------------------");
  console.log("              SEARCHING FOR              ");
  console.log("-----------------------------------------");
  console.log("|   HEX  |  TAG BITS | DATA | OFFSET | ");
  console.log("-----------------------------------------");
  console.log("| "+ hex + " | " + tag_bits + " | " + bit_selector_bits + "  |  " + disected_bits[2] + "  | ");

  result = cache.hitOrMiss(bit_selector_bits, tag_bits);

  console.log("\n\n-----------------------------------------");
  console.log("       ***    RESULT = " + result +"       ***    ");
  console.log("-----------------------------------------");

  // Check if hit or miss for address
  if(result == "HIT")
    hits += 1;
  else
    misses += 1;

  //console.log(cache.cache_matrix)
  //console.log("| "+ hex + " | " + tag_bits + " | " + bit_selector_bits + "  |  " + disected_bits[2] + "  | " + result);
}

// // Generate binary for hex address
// binary = cache.hexToBinary(hex);
// console.log("Binary of address -> " +binary);
//
// // Disect binary address
// disected_bits = cache.disectBinary(binary);
// bit_selector_bits = disected_bits[0];
// tag_bits = disected_bits[1];
//
// // Check if hit or miss for address
// if(cache.hitOrMiss(bit_selector_bits, tag_bits) == "HIT")
//   hits += 1;
// else
//   misses += 1;

console.log("\nTotal Hit Count = " + hits);
console.log("Total Miss Count = " + misses);