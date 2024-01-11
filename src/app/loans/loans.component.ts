import { Component, OnInit, ViewChild } from "@angular/core";
import { MatPaginator } from "@angular/material/paginator";
import { MatSort, Sort } from "@angular/material/sort";
import { MatTableDataSource } from "@angular/material/table";
import { LoansService } from "./loans.service";

@Component({
    selector: 'mifosx-loans',
    templateUrl: './loans.component.html',
    styleUrls: ['./loans.component.scss'],
})
export class LoansComponent implements OnInit {

    displayedColumns = ['accountNumber'];
    dataSource: MatTableDataSource<any> = new MatTableDataSource();

    existsLoansToFilter = false;
    notExistsLoansToFilter = false;

    totalRows: number;
    isLoading = false;

    pageSize = 50;
    currentPage = 0;
    filterText = '';

    sortAttribute = '';
    sortDirection = '';

    @ViewChild(MatPaginator) paginator: MatPaginator;
    @ViewChild(MatSort) sort: MatSort;

    constructor(private loansService: LoansService) { }

    ngOnInit(): void {
        this.getLoans();
    }

    private getLoans() {
        this.loansService.getLoans(this.sortAttribute, this.sortDirection, this.currentPage, this.pageSize)
            .subscribe((data: any) => {
                this.dataSource.data = data.content;
            }, (error: any) => {
                console.log(error);
                this.isLoading = false;
            });
    }

    sortChanged(event: Sort) {
        if (event.direction === '') {
            this.sortDirection = '';
            this.sortAttribute = '';
        } else {
            this.sortAttribute = event.active;
            this.sortDirection = event.direction;
        }
        this.resetPaginator();
        this.getLoans();
    }
    resetPaginator() {
        this.currentPage = 0;
        this.paginator.firstPage();
    }
}
