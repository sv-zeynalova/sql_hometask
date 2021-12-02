--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, �������������)
-- SQL: �������� ������� � �������������� ������� (10000 �����, 3 �������, ��� ���� int) � ��������� �� ���������� ������� �� 0 �� 1 000 000. ��������� EXPLAIN �������� � �������� ������� ��������.
create table table_test (
    column1 int,
    column2 int,
    column3 int);
    
explain insert into table_test(column1, column2, column3) 
select (random() *  (1000000-0+1)+0), (random() *  (1000000-0+1)+0), (random() *  (1000000-0+1)+0) 
from generate_series(1,10000);

explain select * 
from table_test

������� ��������:
insert (cost 0-50.0, 1000 �����)
select (cost 0-50.0, 1000 �����)
generate_series() (cost 0-32.50, 1000 �����)

��� ������� :
seq scan 0-155.0, 10000 �����

--�������������)
-- GCP (Google Cloud Platform): ����� GCP ��������� ������ csv � ���� PSQL �� ������ ���������� (��������� ������ bash � ��������� bash) 

select * 
from avocado_test