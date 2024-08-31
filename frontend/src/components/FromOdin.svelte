<div>
  <input type="text" placeholder="enter text here" bind:value={inputStr}>
  <br><br>
  <button on:click={runOdin}>
    Run Odin
  </button>
</div>

<style>
  input {
    padding: 2%;
    text-align: center;
    font-size: 30px;
  }
</style>

<script>
  /*
  	wasm: the wasmMemoryInterface instance (WasmMemoryInterface)
	odin: the wasm instance                (WebAssembly.Instance)
  */
  import { wasm, odin, WasmMemoryInterface } from "../wasm.js"
  
  let inputStr = ""

  function runOdin()
  {
    if (wasm && inputStr != "") {
      // Allocate a string using provided allocator (note: length property only valid for ASCII strings)
      const strPtr = odin.exports.mem_alloc(inputStr.length)
      const strLen = wasm.storeString(strPtr, inputStr)
      // Get the resulting address and create JS string
      const resAddr = odin.exports.do_string(strPtr, strLen)
      inputStr = wasm.loadString(resAddr, strLen)
      // Free the memory
      odin.exports.mem_clear()
    }
  }
</script>
