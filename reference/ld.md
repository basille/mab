# Quick Conversion of Objects of Class ltraj from and to Dataframes

Faster versions of [`ld`](https://rdrr.io/pkg/adehabitatLT/man/ld.html)
and [`dl`](https://rdrr.io/pkg/adehabitatLT/man/ld.html).

## Usage

``` r
ld(ltraj, strict = TRUE)

dl(x, strict = TRUE)
```

## Arguments

- ltraj:

  An object of class `ltraj`.

- strict:

  Logical. Whether to use the regular
  [`ld`](https://rdrr.io/pkg/adehabitatLT/man/ld.html) or
  [`dl`](https://rdrr.io/pkg/adehabitatLT/man/ld.html) functions, which
  enforce more verifications.

- x:

  An object of class `data.frame`, containing at least columns named
  `x, y, date`.

## Details

In [`ld`](https://rdrr.io/pkg/adehabitatLT/man/ld.html),
`strict = FALSE` can be up to 10 times faster, but assumes that the
`ltraj` is well structured (i.e. not modified by the user). In
[`dl`](https://rdrr.io/pkg/adehabitatLT/man/ld.html), `strict = FALSE`
can be up to 20 times faster, but assumes that the trajectory parameters
in the data frame (x/y increments, angles, etc.) are still valid (e.g.
no locations have been removed).

## See also

See [`ld`](https://rdrr.io/pkg/adehabitatLT/man/ld.html) for further
details on the function and all available arguments.

## Author

Modified by Mathieu Basille <mathieu@basille.org>

## Examples

``` r
data(puechcirc)
puechcirc ## class ltraj
#> 
#> *********** List of class ltraj ***********
#> 
#> Type of the traject: Type II (time recorded)
#> * Time zone: Europe/Paris *
#> Regular traject. Time lag between two locs: 600 seconds
#> 
#> Characteristics of the bursts:
#>     id    burst nb.reloc NAs          date.begin            date.end
#> 1 CH93 CH930824       80  16 1993-08-24 17:00:00 1993-08-25 06:10:00
#> 2 CH93 CH930827       69  17 1993-08-27 19:10:00 1993-08-28 06:30:00
#> 3 JE93 JE930827       66  19 1993-08-27 19:20:00 1993-08-28 06:10:00
#> 

## ld
df1 <- adehabitatLT::ld(puechcirc)
df2 <- mab::ld(puechcirc, strict = FALSE)
all.equal(df1, df2)
#> [1] "Attributes: < Component “row.names”: Modes: character, numeric >"              
#> [2] "Attributes: < Component “row.names”: target is character, current is numeric >"
## Note a difference in row names:
attr(df1, "row.names")
#>   [1] "1"   "2"   "3"   "4"   "5"   "6"   "7"   "8"   "9"   "10"  "11"  "12" 
#>  [13] "13"  "14"  "15"  "16"  "17"  "18"  "19"  "20"  "21"  "22"  "23"  "24" 
#>  [25] "25"  "26"  "27"  "28"  "29"  "30"  "31"  "32"  "33"  "34"  "35"  "36" 
#>  [37] "37"  "38"  "39"  "40"  "41"  "42"  "43"  "44"  "45"  "46"  "47"  "48" 
#>  [49] "49"  "50"  "51"  "52"  "53"  "54"  "55"  "56"  "57"  "58"  "59"  "60" 
#>  [61] "61"  "62"  "63"  "64"  "65"  "66"  "67"  "68"  "69"  "70"  "71"  "72" 
#>  [73] "73"  "74"  "75"  "76"  "77"  "78"  "79"  "80"  "210" "310" "410" "510"
#>  [85] "610" "710" "81"  "91"  "101" "111" "121" "131" "141" "151" "161" "171"
#>  [97] "181" "191" "201" "211" "221" "231" "241" "251" "261" "271" "281" "291"
#> [109] "301" "311" "321" "331" "341" "351" "361" "371" "381" "391" "401" "411"
#> [121] "421" "431" "441" "451" "461" "471" "481" "491" "501" "511" "521" "531"
#> [133] "541" "551" "561" "571" "581" "591" "601" "611" "621" "631" "641" "651"
#> [145] "661" "671" "681" "691" "701" "110" "212" "312" "412" "512" "612" "711"
#> [157] "82"  "92"  "102" "112" "122" "132" "142" "152" "162" "172" "182" "192"
#> [169] "202" "213" "222" "232" "242" "252" "262" "272" "282" "292" "302" "313"
#> [181] "322" "332" "342" "352" "362" "372" "382" "392" "402" "413" "422" "432"
#> [193] "442" "452" "462" "472" "482" "492" "502" "513" "522" "532" "542" "552"
#> [205] "562" "572" "582" "592" "602" "613" "622" "632" "642" "652" "662"
attr(df2, "row.names")
#>   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18
#>  [19]  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36
#>  [37]  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54
#>  [55]  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72
#>  [73]  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
#>  [91]  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108
#> [109] 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126
#> [127] 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144
#> [145] 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162
#> [163] 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180
#> [181] 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198
#> [199] 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215

## dl
all.equal(mab::dl(df2), adehabitatLT::dl(df2))
#> [1] TRUE
dl(df2, strict = FALSE)
#> Warning: Parameters of the trajectory are not recomputed.
#> 
#> *********** List of class ltraj ***********
#> 
#> Type of the traject: Type II (time recorded)
#> * Time zone: Europe/Paris *
#> Regular traject. Time lag between two locs: 600 seconds
#> 
#> Characteristics of the bursts:
#>     id    burst nb.reloc NAs          date.begin            date.end
#> 1 CH93 CH930824       80  16 1993-08-24 17:00:00 1993-08-25 06:10:00
#> 2 CH93 CH930827       69  17 1993-08-27 19:10:00 1993-08-28 06:30:00
#> 3 JE93 JE930827       66  19 1993-08-27 19:20:00 1993-08-28 06:10:00
#> 
## Comparison regarding 'strict'
all.equal(dl(df2), dl(df2, strict = FALSE))
#> Warning: Parameters of the trajectory are not recomputed.
#>  [1] "Attributes: < Names: 2 string mismatches >"                                                 
#>  [2] "Attributes: < Length mismatch: comparison on first 3 components >"                          
#>  [3] "Attributes: < Component 2: Modes: S4, logical >"                                            
#>  [4] "Attributes: < Component 2: Attributes: < Modes: list, NULL > >"                             
#>  [5] "Attributes: < Component 2: Attributes: < Lengths: 2, 0 > >"                                 
#>  [6] "Attributes: < Component 2: Attributes: < names for target but not for current > >"          
#>  [7] "Attributes: < Component 2: Attributes: < current is not list-like > >"                      
#>  [8] "Component 1: Attributes: < Component “row.names”: Modes: character, numeric >"              
#>  [9] "Component 1: Attributes: < Component “row.names”: target is character, current is numeric >"
#> [10] "Component 2: Attributes: < Component “row.names”: Modes: character, numeric >"              
#> [11] "Component 2: Attributes: < Component “row.names”: target is character, current is numeric >"
#> [12] "Component 2: Component 8: 'is.NA' value mismatch: 17 in current 69 in target"               
#> [13] "Component 3: Attributes: < Component “row.names”: Modes: character, numeric >"              
#> [14] "Component 3: Attributes: < Component “row.names”: target is character, current is numeric >"
## Differences in row.names (numeric in regular 'dl', characters using
## 'strict = FALSE') + NAs in R2n (for a reason, 'puechcirc[[2]]'
## starts by a sequence of missing values, but has several 'R2n'
## values. As a result, 'strict = FALSE' keeps the 'R2n' values)
```
