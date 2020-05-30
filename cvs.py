import requests
import lxml.html as lh

url = 'https://cvshealth.com/covid-19/testing-locations'
#Create a handle, page, to handle the contents of the website
page = requests.get(url)

#Store the contents of the website under doc
doc = lh.fromstring(page.content)

#Parse data that are stored between <tr>..</tr> of HTML
tr_elements = doc.xpath('//li[@class="result"]')

addresses = open("cvsaddress.txt", "a")
#Create empty list
col=[]
i=0
#For each row, store each first element (header) and an empty list
for t in tr_elements[0]:
    i+=1
    name=t.text_content()
    print '%d:"%s"'%(i,name)
    col.append((name,[]))

#Since out first row is the header, data is stored on the second row onwards
for j in range(1,len(tr_elements)):
    #T is our j'th row
    T=tr_elements[j]
    
    #i is the index of our column
    i=0
    address = ""
    #Iterate through each element of the row
    for t in T.iterchildren():
        data=t.text_content() 
        if i == 2:
        	data = "".join(data.split("- "))
        if i == 0:
        	address = data
        if i > 0:
        	address = address + ", " + data
        i+=1
    #Append address to txt file
    print >>addresses, address