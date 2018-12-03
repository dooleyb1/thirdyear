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
    var empty_tag = "EMPTY_TAG";
    var empty_data = "EMPTY_DATA"

    // For each cache set - down (N)
    for(var i=0; i<this.N; i++){

      // Generate binary for set number and set valid to 0
      var set_number = (i).toString(2).padStart(this.set_selector_bits_length, 0);

      this.cache_matrix.push([set_number])

      for(var j=0; j<this.K; j++){
        this.cache_matrix[i].push(empty_tag)
      }

      // For each cache tag in set - across (K)
      for(j=0; j<this.K; j++) {
        var last_updated = this.getTime()
        this.cache_matrix[i].push([empty_data, last_updated])

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
    //console.log(this.cache_matrix)

  }

  printCache(){
    var string = "| SET |"
    var line = "--------"

    for(var i=0; i<this.K; i++){
        string += "    TAG    |"
        line +=   "------------"
    }

    string += "||"
    line += "--"

    for(var i=0; i<this.K; i++){
      string += "        DATA        |"
      line +=   "---------------------"
    }

    console.log("\n" + line)
    console.log(string);
    console.log(line)

    // For each cache set - down (N)
    for(var i=0; i<this.N; i++){
      var contents_string = "| " + this.cache_matrix[i][0] + " |";
      // For each cache tag in set N - across (K)
      for(var j=0; j<this.K; j++) {
        contents_string += " " + this.cache_matrix[i][j+1] + " |"
      }

      contents_string += "||"

      // For each cache tag in set N - across (K)
      for(var j=0; j<this.K; j++) {
        if(this.cache_matrix[i][this.K+j+1][0] == "EMPTY_DATA")
          contents_string += "     " + this.cache_matrix[i][this.K+j+1][0] + "     |"
        else
          contents_string += " " + this.cache_matrix[i][this.K+j+1][0] + " |"

      }
      console.log(contents_string)
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

  findIndexOfLRUTag(timestamps){

    var oldest = Math.min.apply(null, timestamps);
    var index = timestamps.indexOf(oldest)
    return index
  }

  handleOneDataDirectory(tag_bits, row){
    // If EMPTY_TAG then miss
    if(row[1] == "EMPTY_TAG"){
      // Return miss and pretend fetch from memory
      row[1] = tag_bits;
      row[2][0] = "DATA_FOR_" + tag_bits
      return("MISS");
    }
    // Otherwise it has tag, verify tag
    else{
      // && If tag_bits_match()
      if(row[1] == tag_bits)
        return("HIT");
      else{
        // Return miss and pretend fetch from memory
        row[1] = tag_bits;
        row[2][0] = "DATA_FOR_" + tag_bits
        return("MISS")
      }
    }
  }

  handleLRUReplacement(tag_bits, row){
    var timestamps = [];

    // Loop over all tags for cache set looking for match
    for(var index=1; index<=this.K; index++){
      timestamps.push(row[this.K+index][1]);

      // If tag match and data in cache, update LRU and return hit
      if(row[index] == tag_bits && row[this.K+index] != "EMPTY_DATA"){
        // Update time for LRU
        row[this.K+index][1] = this.getTime();
        return("HIT")
      }
    }

    // If no tag hit found, check LRU and replace
    var lruIndex = this.findIndexOfLRUTag(timestamps);

    // If empty, simulate MISS and fetch
    if(row[1+lruIndex] == "EMPTY_TAG"){
      row[1+lruIndex] = tag_bits;
      row[1+this.K+lruIndex][1] = this.getTime();
      row[1+this.K+lruIndex][0] = "DATA_FOR_" + tag_bits
      return("MISS");
    }
    // Otherwise, replace entry and simulate MISS and fetch
    else{
      row[1+lruIndex] = tag_bits;
      row[1+this.K+lruIndex][1] = this.getTime();
      row[1+this.K+lruIndex][0] = "DATA_FOR_" + tag_bits
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

// Bytes of data per cache line
const L = 16
// Number of directories (across)
const K = 8
// Number of sets (down)
const N = 1

const builtCache = new Cache(L,K,N)

var input1 = ["0x0000","0x0004","0x000c","0x2200","0x00d0","0x00e0","0x1130","0x0028",
        		 "0x113c","0x2204","0x0010","0x0020","0x0004","0x0040","0x2208","0x0008",
        		 "0x00a0","0x0004","0x1104","0x0028","0x000c","0x0084","0x000c","0x3390",
        		 "0x00b0","0x1100","0x0028","0x0064","0x0070","0x00d0","0x0008","0x3394"]

var input2 = ["0x0000","0x0010","0x0020","0x0030",
              "0x0034","0x0020","0x0010","0x00c",
              "0x0050","0x0040","0x002c","0x0008",
              "0x0030","0x0020","0x0010","0x0000",]

var hits = 0;
var misses = 0;

// Input variables
var input = input1;
var cache = builtCache;

console.log("\n|   HEX  |  TAG BITS | DATA | OFFSET | RESULT ");
console.log("-----------------------------------------------");

// Test all input hex addresses
for(var i=0; i<input.length; i++){

  var hex = input[i];
  // Generate binary for hex address
  binary = cache.hexToBinary(hex);

  // Disect binary address
  disected_bits = cache.disectBinary(binary);
  bit_selector_bits = disected_bits[0];
  tag_bits = disected_bits[1];
  //
  // console.log("\n\n-----------------------------------------");
  // console.log("              SEARCHING FOR              ");
  // console.log("-----------------------------------------");
  // console.log("|   HEX  |  TAG BITS | SET | OFFSET | ");
  // console.log("-----------------------------------------");
  // console.log("| "+ hex + " | " + tag_bits + " | " + bit_selector_bits + "  |  " + disected_bits[2] + "  | ");

  result = cache.hitOrMiss(bit_selector_bits, tag_bits);

  console.log("| "+ hex + " | " + tag_bits + " | " + bit_selector_bits + "  |  " + disected_bits[2] + "  | " + result);

  // console.log("\n\n-----------------------------------------");
  // console.log("       ***    RESULT = " + result +"       ***    ");
  // console.log("-----------------------------------------");
  //
  // console.log("\n\n-----------------------------------------");
  // console.log("              CACHE AFTER               ");
  // console.log("-----------------------------------------");
  // console.log(cache.printCache())

  // Check if hit or miss for address
  if(result == "HIT")
    hits += 1;
  else
    misses += 1;
}


console.log("\nTotal Hit Count = " + hits);
console.log("Total Miss Count = " + misses);
