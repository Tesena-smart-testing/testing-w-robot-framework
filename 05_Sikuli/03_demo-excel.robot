*** Settings ***
Documentation     Sikuli library demo for Excel
Library           SikuliLibrary
Library           String
Test Setup        Set Sikuli Image Path
Test Teardown     Stop Remote Server

*** Variables ***
${IMAGE_DIR}            ${CURDIR}\\img\\03_img_excel

${SHEET NAME}           sikuli-demo

@{CELL SELECTOR LIST FOR HEADER}    H10  I10  J10
@{CELL SELECTOR LIST FOR NAME}      H11  H12  H13  H14
@{CELL SELECTOR LIST FOR POSITION}  I11  I12  I13  I14
@{CELL SELECTOR LIST FOR SALARY}    J11  J12  J13  J14

@{HEADER}       NAME  POSITION  SALARY
@{NAME}         Adam  Eva  Anna  Josef
@{POSITION}     Junior Tester  SCRUM Master  Analyst  Test Automation Engineer
@{SALARY}       35000  45000  42000  50000

*** Test Cases ***
Excel Test
    Open Excel
    Change Sheet Name
    Input Data In Excel
    Format Data As Table
    Create And Move Graph
    Quit Excel Without Saving File

*** Keywords ***
Set Sikuli Image Path
    Directory Should Exist    ${IMAGE_DIR}
    Add Image Path            ${IMAGE_DIR}
    Set Min Similarity        0.8

Open Excel
    Wait Until Screen Contain                       search_input_win10_eng.png  15
    Input Text                                      search_input_win10_eng.png  Excel
    Wait Until Screen Contain	                    excel_app_win10_icon.png	15
    Click                                           excel_app_win10_icon.png
    Wait Until Screen Contain	                    blank_workbook.png	        15
    Click                                           blank_workbook.png
    Set Min Similarity	0.99
    ${excel_maximize}   Exists	                    maximize_excel.png          15
    Run Keyword If  ${excel_maximize}  Click        maximize_excel.png
    # Alternative option:
    # Run Keyword If  ${excel_maximize}  Click In   min_max_close_buttons_excel.png  maximize_excel.png

Change Sheet Name
    Wait Until Screen Contain                       sheet1_en.png               15
    Right Click                                     sheet1_en.png
    Wait Until Screen Contain                       rename_sheet_en.png         15
    Click                                           rename_sheet_en.png
    Wait Until Screen Contain                       sheet1_highlighted_en.png   15
    Press Special Key                               BACKSPACE
    Input Text                                      ${EMPTY}  ${SHEET NAME}
    Press Special Key                               ENTER

Input Data In Excel
    Wait Until Screen Contain                       cell_selector.png	        15
    ${Header Length}    Get Length                  ${HEADER}
    Set Test Variable                               ${Header Length}
    ${Name Length}      Get Length                  ${NAME}
    ${Position Length}  Get Length                  ${POSITION}
    ${Salary Length}    Get Length                  ${SALARY}

    Run Keyword If  ${Header Length} != 0           Input Header Data In Excel
    Run Keyword If  ${Name Length} != 0             Input Name Data In Excel
    Run Keyword If  ${Position Length} != 0         Input Position Data In Excel
    Run Keyword If  ${Salary Length} != 0           Input Salary Data In Excel

Input Header Data In Excel
   ${length}=    Get Length     ${CELL SELECTOR LIST FOR HEADER}
   FOR    ${i}    IN RANGE      ${length}
       Input Text               cell_selector.png  ${CELL SELECTOR LIST FOR HEADER}[${i}]
       Sleep                    0.2s
       Press Special Key        ENTER
       Input Text               ${EMPTY}  ${HEADER}[${i}]
       Press Special Key        ENTER
   END

Input Name Data In Excel
   ${length}=    Get Length     ${CELL SELECTOR LIST FOR NAME}
   FOR    ${i}    IN RANGE      ${length}
       Input Text               cell_selector.png  ${CELL SELECTOR LIST FOR NAME}[${i}]
       Sleep                    0.2s
       Press Special Key        ENTER
       Input Text               ${EMPTY}  ${NAME}[${i}]
       Press Special Key        ENTER
   END

Input Position Data In Excel
   ${length}=    Get Length     ${CELL SELECTOR LIST FOR POSITION}
   FOR    ${i}    IN RANGE      ${length}
       Input Text               cell_selector.png  ${CELL SELECTOR LIST FOR POSITION}[${i}]
       Sleep                    0.2s
       Press Special Key        ENTER
       Input Text               ${EMPTY}  ${POSITION}[${i}]
       Press Special Key        ENTER
   END

Input Salary Data In Excel
   ${length}=    Get Length     ${CELL SELECTOR LIST FOR SALARY}
   FOR    ${i}    IN RANGE      ${length}
       Input Text               cell_selector.png  ${CELL SELECTOR LIST FOR SALARY}[${i}]
       Sleep                    0.2s
       Press Special Key        ENTER
       Input Text               ${EMPTY}  ${SALARY}[${i}]
       Press Special Key        ENTER
   END

Format Data As Table
   Wait Until Screen Contain	     format_as_table.png	    15
   Click                             format_as_table.png
   Wait Until Screen Contain	     table_style_light_14.png	15
   Click                             table_style_light_14.png
   Wait Until Screen Contain	     create_table_en.png	    15
   # Advanced option:
   # Press Special Key               BACKSPACE
   # Input Text  ${EMPTY}  ${CELL SELECTOR LIST FOR HEADER}[0]:${CELL SELECTOR LIST FOR SALARY}[-1]
   # Run Keyword If  ${Header Length} == 0   Click    table_headers_en.png
   # Sleep  1s
   Click In                          ok_cancel_button.png       ok_button.png

Create And Move Graph
   Wait Until Screen Contain	     home_insert_en.png	        15
   Click In                          home_insert_en.png         insert_en.png
   Wait Until Screen Contain	     bar_chart.png	            15
   Click                             bar_chart.png
   Wait Until Screen Contain	     stacked_bar.png	        15
   Click                             stacked_bar.png
   Sleep                             1s
   Mouse Move                        graph_corner.png
   Mouse Down	                     LEFT
   Drag And Drop By Offset           graph_corner.png     300   -150  

Quit Excel Without Saving File
    Wait Until Screen Contain        close_excel.png            15
    Click                            close_excel.png    
    Wait Until Screen Contain        dont_save_excel_en.png     15
    Click                            dont_save_excel_en.png