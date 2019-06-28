class ucm::product::tools (
  $product_tools = lookup('product::tools')
){
  notify {
    'MSGTOOLS':
      message => '...MANAGING TOOLS CONFIGURATION IF ANY'
  }

  create_resources('ucm::custom::tools', $product_tools)
}
