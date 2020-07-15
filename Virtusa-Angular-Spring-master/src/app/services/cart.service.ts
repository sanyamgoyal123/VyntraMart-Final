import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

import {apiUrl} from '../../environments/environment';
import {CookieService} from 'ngx-cookie-service';
import {BehaviorSubject, Observable, of} from 'rxjs';
import {catchError, map, tap} from 'rxjs/operators';
import {UserService} from './user.service';
import {Cart} from '../models/Cart';
import {Item} from '../models/Item';
import {JwtResponse} from '../response/JwtResponse';
import {ProductInOrder} from '../models/ProductInOrder';
import { prod } from '../mockData';

@Injectable({
    providedIn: 'root'
})
export class CartService {


    private cartUrl = `${apiUrl}/cart`;

    localMap = {};


    private itemsSubject: BehaviorSubject<Item[]>;
    private totalSubject: BehaviorSubject<number>;
    public items: Observable<Item[]>;
    public total: Observable<number>;


    private currentUser: JwtResponse;

    constructor(private http: HttpClient,
                private cookieService: CookieService,
                private userService: UserService) {
        this.itemsSubject = new BehaviorSubject<Item[]>(null);
        this.items = this.itemsSubject.asObservable();
        this.totalSubject = new BehaviorSubject<number>(null);
        this.total = this.totalSubject.asObservable();
        this.userService.currentUser.subscribe(user => this.currentUser = user);


    }
    productList:any;
    private getLocalCart(): ProductInOrder[] {
        if (this.cookieService.check('cart')) {
            this.localMap = JSON.parse(this.cookieService.get('cart'));
            return Object.values(this.localMap);
        } else {
            this.localMap = {};
            return [];
        }
    }


    payment(productListData)
    {
        return this.http.post<boolean>("http://www.payumoney.com",productListData);
    }
    getCart(): Observable<ProductInOrder[]> {
        const localCart = this.getLocalCart();
        this.productList=localCart;
        if (this.currentUser) {
            if (localCart.length > 0) {
                console.log("URL    ",this.cartUrl, localCart)
                return this.http.post<Cart>(this.cartUrl, localCart).pipe(
                    tap(_ => {
                      //  this.clearLocalCart();
                    }),
                    map(cart => cart.products),
                    catchError(_ => of([]))
                );
            } else {
                return this.http.get<Cart>(this.cartUrl).pipe(
                    map(cart => cart.products),
                    catchError(_ => of([]))
                );
            }
        } else {
            return of(localCart);
        }
    }

    addItem(productInOrder): Observable<boolean> {
        
        if (!this.currentUser) {
            console.info("value")
            console.log(productInOrder)
            if (this.cookieService.check('cart')) {
                this.localMap = JSON.parse(this.cookieService.get('cart'));
            }
            if (!this.localMap[productInOrder.productId]) {
                this.localMap[productInOrder.productId] = productInOrder;
            } else {
                this.localMap[productInOrder.productId].count += productInOrder.count;
            }
            this.cookieService.set('cart', JSON.stringify(this.localMap));
            return of(true);
        } else {
            const url = `${this.cartUrl}/add`;
            console.log("Data  ",url)
            return this.http.post<boolean>(url, {
                'quantity': productInOrder.count,
                'productId': productInOrder.productId
            });
        }
    }

    update(productInOrder): Observable<ProductInOrder> {

        if (this.currentUser) {
            const url = `${this.cartUrl}/${productInOrder.productId}`;
            return this.http.put<ProductInOrder>(url, productInOrder.count);
        }
    }


    remove(productInOrder) {
        if (!this.currentUser) {
            delete this.localMap[productInOrder.productId];
            return of(null);
        } else {
            const url = `${this.cartUrl}/${productInOrder.productId}`;
            return this.http.delete(url).pipe( );
        }
    }


    checkout(): Observable<any> {
        const url = `${this.cartUrl}/checkout`;
        return this.http.post(url, null).pipe();
    }

    storeLocalCart() {
        this.cookieService.set('cart', JSON.stringify(this.localMap));
    }

    clearLocalCart() {
        console.log('clear local cart');
        this.cookieService.delete('cart');
        this.localMap = {};
    }

}
