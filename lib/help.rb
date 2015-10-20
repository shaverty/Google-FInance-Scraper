require'net/http'
quote_symbols = gets.chomp


"""""A quick search for stocks through Google Finance
The Google Finance feed can return some or all of the following
keys:

  avvo    * Average volume (float with multiplier, like '3.54M')
  beta    * Beta (float)
  c       * Amount of change while open (float)
  ccol    * (unknown) (chars)
  cl        Last perc. change
  cp      * Change perc. while open (float)
  e       * Exchange (text, like 'NASDAQ')
  ec      * After hours last change from close (float)
  eccol   * (unknown) (chars)
  ecp     * After hours last chage perc. from close (float)
  el      * After. hours last quote (float)
  el_cur  * (unknown) (float)
  elt       After hours last quote time (unknown)
  eo      * Exchange Open (0 or 1)
  eps     * Earnings per share (float)
  fwpe      Forward PE ratio (float)
  hi      * Price high (float)
  hi52    * 52 weeks high (float)
  id      * Company id (identifying number)
  l       * Last value while open (float)
  l_cur   * Last value at close (like 'l')
  lo      * Price low (float)
  lo52    * 52 weeks low (float)
  lt        Last value date/time
  ltt       Last trade time (Same as 'lt' without the data)
  mc      * Market cap. (float with multiplier, like '123.45B')
  name    * Company name (text)
  op      * Open price (float)
  pe      * PE ratio (float)
  t       * Ticker (text)
  type    * Type (i.e. 'Company')
  vo      * Volume (float with multiplier, like '3.54M')

  * - Provided in the feed.


Usage:
stock_data= load_quote(symbol)
return stock_data[key]

Note:
Capitalization doesn't affect the output, nor do comma's or periods.

"""


# @param symbol [Object]
def load_quote(symbol)
  connection = URI('http://www.google.com/finance/info?infotype=infoquoteall&q=' + symbol)
  raw_data = Net::HTTP.get(connection)

  dict = {}
  raw_data.each_line do |line|
    line = line.chomp
    line_parts = line.split(':')
    if line_parts.length == 2
      key, value = line_parts
      key = key.gsub(34.chr,'')
      key = (key.gsub(/\,/, '')).strip

      value = (value.gsub(34.chr, '')).strip
      dict[key] = value if key and value
      end
  end
  return "Invalid Symbol" if dict['hi'] == ""
  dict
end


stock_data = load_quote(quote_symbols)
high = stock_data['hi']
low = stock_data['lo']
volume = stock_data['vo']
exchange = stock_data['e']

puts exchange
puts high
puts low
puts volume
